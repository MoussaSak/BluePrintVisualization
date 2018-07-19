Class {
	#name : #SuffixScanReport,
	#superclass : #VocabularyScanReport,
	#instVars : [
		'suffix',
		'classes',
		'classNames',
		'hierarchies',
		'packages',
		'classScanReports',
		'dominantHierarchieInPackages'
	],
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #'as yet unclassified' }
SuffixScanReport class >> with: aSingleClassScanReport [
	^self new
		classScanReports: (Set with: aSingleClassScanReport)
		"classNames: (Set with: (aSingleClassScanReport at: 'className'));
		classes: (Set with: (aSingleClassScanReport at: 'scannedClasses'));
		hierarchies: (Bag with: (aSingleClassScanReport at: 'rootClass'));
		suffix: (aSingleClassScanReport at: 'classSuffix'); 
		packages: (Set with: (aSingleClassScanReport at: 'package'))"
]

{ #category : #accessing }
SuffixScanReport >> classNames [
	^ classNames ifNil: [ classNames := classScanReports collect: [ :each| each at: 'className' ] ]
]

{ #category : #accessing }
SuffixScanReport >> classScanReports [
	^ classScanReports
]

{ #category : #accessing }
SuffixScanReport >> classScanReports: aSet [
	classScanReports := aSet
]

{ #category : #accessing }
SuffixScanReport >> classes [
	^ classes ifNil: [ classes := classScanReports collect: [ :each| each at: 'className' ] ]
]

{ #category : #accessing }
SuffixScanReport >> dominantHierarchie [
	^self dominantHierarchies first
]

{ #category : #statistics }
SuffixScanReport >> dominantHierarchieInPackages [
	|associationsOfPackagesAndHierarchies numberOfclassesBelongingToDominantHierarchy|
	^dominantHierarchieInPackages ifNil:
	[associationsOfPackagesAndHierarchies := classScanReports asBag collect: [ :each| (each at: 'package')->(each at: 'rootClass') ].
	numberOfclassesBelongingToDominantHierarchy := (associationsOfPackagesAndHierarchies select: [ :each| each value = self dominantHierarchie key first]).
	dominantHierarchieInPackages := packages collect: [:each| each -> ((numberOfclassesBelongingToDominantHierarchy select: [:ass| ass key = each ]) size / (classScanReports select: [ :report| (report at: 'package') = each]) size) ]]
]

{ #category : #accessing }
SuffixScanReport >> dominantHierarchies [

	^self hierarchies sortedCounts collect: [ :association| {association value . association value parentPackage} -> (association key/self hierarchies size) ]
]

{ #category : #accessing }
SuffixScanReport >> hierarchies [
	^ hierarchies ifNil: [ hierarchies := classScanReports asBag collect: [ :each| each at: 'rootClass' ] ]
]

{ #category : #statistics }
SuffixScanReport >> mergeWith: aCollection [ 
	aCollection do: [ :each| each suffix = suffix ifFalse: ["Fatal error: trying to merge two different suffixes in one"self halt.]].
	self classScanReports addAll: (aCollection flatCollect: #classScanReports).
	self resetClasses.
	self resetClassNames.
	self resetHierarchies.
	self resetPackages.
]

{ #category : #accessing }
SuffixScanReport >> mouseAnnouncer [
	^RTSuffixScanReportPopup new text: self viewInClassBluePrint
]

{ #category : #accessing }
SuffixScanReport >> numberOfClasses [
	^self classes size.
]

{ #category : #accessing }
SuffixScanReport >> packages [
	^ packages ifNil: [ packages := classScanReports collect: [ :each| each at: 'package' ] ]
]

{ #category : #accessing }
SuffixScanReport >> resetClassNames [
	classNames := nil
]

{ #category : #accessing }
SuffixScanReport >> resetClasses [
	classes := nil
]

{ #category : #accessing }
SuffixScanReport >> resetHierarchies [
	hierarchies := nil
]

{ #category : #accessing }
SuffixScanReport >> resetPackages [
	packages := nil
]

{ #category : #accessing }
SuffixScanReport >> suffix [
	^ suffix ifNil: [ suffix := classScanReports anyOne at: 'classSuffix' ]
]

{ #category : #accessing }
SuffixScanReport >> suffix: aString [ 
	suffix := aString 
]

{ #category : #visualization }
SuffixScanReport >> viewInClassBluePrint [
	|dominantHierarchyStatName packageOfDominantHierarchy RatioOfClassesBelongingToDominantHierarchy hierarchyDominantedpackages mediumDominanceInDominatedPackages mediumDominanceInDominatedPackagesMsg dominanceLevel numberOfClassesUsingThisSuffixInTheDominatedPackage |
	dominanceLevel := 0.8.
	dominantHierarchyStatName := self dominantHierarchie key first name.
	packageOfDominantHierarchy := self dominantHierarchie key second name.
	RatioOfClassesBelongingToDominantHierarchy := (self dominantHierarchie value * 100) asFloat rounded asString, '% '.
	
	
	hierarchyDominantedpackages := (self dominantHierarchieInPackages select: [ :asso|
	asso value > dominanceLevel
	 ]).

hierarchyDominantedpackages ifNotEmpty:[ mediumDominanceInDominatedPackages := (hierarchyDominantedpackages inject: 0 into: [ :sum :each| sum + each value ]) / hierarchyDominantedpackages size.
	numberOfClassesUsingThisSuffixInTheDominatedPackage := (self classScanReports select: [ :each| (hierarchyDominantedpackages collect: #key) includes: (each at: 'package')]) size.
	mediumDominanceInDominatedPackagesMsg := (mediumDominanceInDominatedPackages * 100) asFloat rounded asString, '% of the ', numberOfClassesUsingThisSuffixInTheDominatedPackage asString, ' classes using this suffix in these packages are subclasses of the dominant hierarchy']
ifEmpty: [ |maxDominance|
	maxDominance := (self dominantHierarchieInPackages collect: #value)max.
	mediumDominanceInDominatedPackages := self dominantHierarchieInPackages select: [ :each| each value >= (1/2)"maxDominance" ].
	 mediumDominanceInDominatedPackagesMsg := 'Only ', mediumDominanceInDominatedPackages size asString, 'package(s) associate this suffix to the dominant hierarchy in ', (maxDominance*100) asFloat rounded asString, '% of cases' ] .
	^'Suffix: ',(self suffix), String cr,
	
	 RatioOfClassesBelongingToDominantHierarchy, 'of the ', self classes size asString, ' classes using this suffix are subclasses of ', packageOfDominantHierarchy, '>>', dominantHierarchyStatName, String cr,
	
self dominantHierarchies size asString, 'hierarchies use this suffix', String cr,
self dominantHierarchieInPackages size asString , ' package(s) use this suffix', String cr,
'out of which ', hierarchyDominantedpackages size asString, ' package(s) associate it to the dominant hierarchy at more than ', (dominanceLevel * 100) asString ,'%', String cr,
mediumDominanceInDominatedPackagesMsg
]
