Class {
	#name : #FAMIXPackagesGroupScanner,
	#superclass : #VocabularyScanner,
	#instVars : [
		'availableColors'
	],
	#category : #'ClassNamesAnalyzer-Core'
}

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> allColors [
	^(((Color colorNamesXKCD collect:#second) reject: [ :each|each size<3 ] )collect: [ :each|
	Color fromRgbTriplet: each ])
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> reportClass [
	^GroupOfPackagesScanReport
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> scan: aFAMIXPackageGroup [ 
	"^(self new scannedEntities: aFAMIXPackageGroup) generateaClassNamesScanReport;yourself."
	^super scan: aFAMIXPackageGroup 
]

{ #category : #'visualization-private' }
FAMIXPackagesGroupScanner >> addBlueprintLegendOn: view [

	| lb |
	lb := RTLegendBuilder new.
	"lb onDemand."
	lb view: view.
 	((self classNamesScanReport at: 'allRootClasses') asSet collect: #key) do: [ :each | lb addColor: (self scannedPackages mooseModel dictionaryOfRootClassColors at: each) text: each name].
	"lb addColor: Color blue text: 'TestAsserter hierarchy'"
	lb build


]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allCoherentHierarchies [
	^self allHierarchies select: [:each | each allHierarchySuffixes size = 1].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allCoherentSuffixes [
	^self allSuffixes select: [ :each | each value hierarchies asSet size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allHierarchies [
	^((self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses') reject: [ :each | each value classNamesScanReport at: 'isMetaRoot']) collect: [ :each | each value classNamesScanReport ].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allInCoherentSuffixes [
	^self allSuffixes select:  [ :each| each value hierarchies asSet size > 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allIncoherentHierarchies [
	^self allHierarchies select: [:each | each allHierarchySuffixes size > 1].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassCoherentHierarchies [
	^self allMultiClassHierarchies select: [ :each| each allHierarchySuffixes size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassCoherentSuffixes [
	^self allMultiClassSuffixes select: [ :each| each value hierarchies asSet size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassHierarchies [
	^self allHierarchies select: [ :each | each scannedEntity allSubInheritances size >= 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassSuffixes [
	^self allSuffixes select: [ :each | each key > 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allSuffixes [
	^self classNamesScanReport at: 'allClassNameSuffixesSorted'.
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeAllClassNameSuffixesSorted [
	| suffixScanReports |
	suffixScanReports := ((self classNamesScanReport subEntityScanReports
		collect:
			[ :aPackageScanReport | aPackageScanReport at: 'allClassNameSuffixesSorted' ])
		flatCollect: #value) collect: #value.
	^ self allClassNameSuffixesSorted: suffixScanReports
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeAllClassesGroupedByRootClassesFor: aGroupOfScanReports [
	| aDictionary |
	aDictionary := Dictionary new.
	(self classNamesScanReport
		at: 'allRootClasses'
		ifAbsentPut: [ (self defaultMetrics at: 'allRootClasses')
				value: aGroupOfScanReports ])
		do: [ :anAssociation | 
			| root subClass |
			root := anAssociation key.
			subClass := anAssociation value.
			aDictionary
				at: root
				ifPresent: [ (aDictionary at: root)
						add: subClass;
						yourself ]
				ifAbsentPut: [ Bag with: subClass ] ].
	^ aDictionary
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeAllRootClassesAsSetFor: aGroupOfScanReports [
	^ (self classNamesScanReport
		at: 'allRootClassesSortedByNumberOfSubClasses'
		ifAbsentPut: [ (self defaultMetrics at: 'allRootClassesSortedByNumberOfSubClasses')
				value: aGroupOfScanReports ]) collect: #value
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeColorsOfRootClassesFor: aGroupOfScanReports [
	| i aDictionaryOfColors |
	aDictionaryOfColors := self scannedEntities mooseModel
		dictionaryOfRootClassColors
		ifNil: [ aDictionaryOfColors := Dictionary new ].
	i := aDictionaryOfColors size.
	^ (self classNamesScanReport
		at: 'allRootClassesSortedByNumberOfSubClasses'
		ifAbsentPut: [ (self defaultMetrics at: 'allRootClassesSortedByNumberOfSubClasses')
				value: aGroupOfScanReports ])
		do: [ :aRootClass | 
			aDictionaryOfColors
				at: aRootClass
				ifAbsent: [ aRootClass value isMetaRoot
						ifTrue: [ aDictionaryOfColors at: aRootClass value put: (Color gray: 1) ]
						ifFalse: [ aRootClass value vocabularyScanner classNamesScanReport
								allSubclasses size > 1
								ifTrue: [ aRootClass value vocabularyScanner classNamesScanReport
										numberOfSuffixes = 1
										ifTrue: [ aDictionaryOfColors at: aRootClass value put: Color gray ]
										ifFalse: [ i := i + 1.
											aDictionaryOfColors
												at: aRootClass value
												put: (self pickAnAvailableColorNumber: i) ] ]
								ifFalse: [ aDictionaryOfColors at: aRootClass value put: Color white ] ].
					self saveInMooseModel: aDictionaryOfColors ] ]
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeDominantRootsInSuffixFor: aGroupOfScanReports [
	^ ((self classNamesScanReport
		at: 'hierarchiesGroupedBySuffixes'
		ifAbsentPut: [ (self defaultMetrics at: 'hierarchiesGroupedBySuffixes')
				value: aGroupOfScanReports ]) associations
		collect: [ :association | association key -> association value sortedCounts ])
		asDictionary
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeHierarchiesGrouperBySuffixesFor: aGroupOfScanReports [
	^ ((self classNamesScanReport
		at: 'allClassNameSuffixesSorted'
		ifAbsentPut: [ (self defaultMetrics at: 'allClassNameSuffixesSorted')
				value: aGroupOfScanReports ])
		collect:
			[ :association | association value suffix -> association value hierarchies ])
		asDictionary
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> computeSuffixesGroupedByRootClassesFor: aGroupOfScanReports [
	| aDictionary |
	aDictionary := Dictionary new.
	^ (self classNamesScanReport
		at: 'allClassesGroupedByRootClasses'
		ifAbsentPut: [ (self defaultMetrics at: 'allClassesGroupedByRootClasses')
				value: aGroupOfScanReports ]) associations
		collect: [ :association | 
			association key
				-> (association value collect: [ :aReport | aReport at: 'classSuffix' ]) ]
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages'
			put: [ :aGroupOfScanReports | aGroupOfScanReports size ];
		at: 'allClasses'
			put: [ :aGroupOfScanReports | 
			aGroupOfScanReports
				flatCollect: [ :aPackageScanReport | aPackageScanReport at: 'allClasses' ] ];
		at: 'classNames'
			put: [ :aGroupOfScanReports | 
			aGroupOfScanReports
				flatCollect: [ :aPackageScanReport | aPackageScanReport at: 'classNames' ] ];
		at: 'allRootClasses'
			put: [ :aGroupOfScanReports | 
			aGroupOfScanReports
				flatCollect: [ :aPackageScanReport | aPackageScanReport at: 'allRootClasses' ] ];
		at: 'hierarchiesGroupedBySuffixes'
			put:
				[ :aGroupOfScanReports | self computeHierarchiesGrouperBySuffixesFor: aGroupOfScanReports ];
		at: 'allClassNameSuffixesSorted'
			put: [ :aGroupOfScanReports | 
			"|aDictionary|
			aDictionary := Dictionary new.
(self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) collect: [:association|
	|suffix rootClass|
	suffix := association value at: 'classSuffix'.
	rootClass := association key.
	aDictionary at: suffix ifPresent: [(aDictionary at: suffix) add: rootClass ] ifAbsentPut: [Bag with: rootClass] ].
	aDictionary"
			self computeAllClassNameSuffixesSorted ];
		at: 'dominantRootsInSuffix'
			put:
				[ :aGroupOfScanReports | self computeDominantRootsInSuffixFor: aGroupOfScanReports ];
		at: 'suffixesGroupedByRootClasses'
			put:
				[ :aGroupOfScanReports | self computeSuffixesGroupedByRootClassesFor: aGroupOfScanReports ];
		at: 'allClassesGroupedByRootClasses'
			put:
				[ :aGroupOfScanReports | self computeAllClassesGroupedByRootClassesFor: aGroupOfScanReports ];
		at: 'allRootClassesSortedByNumberOfSubClasses'
			put: [ :aGroupOfScanReports | 
			((self classNamesScanReport
				at: 'allRootClasses'
				ifAbsentPut: [ (self defaultMetrics at: 'allRootClasses')
						value: aGroupOfScanReports ]) collect: #key) asBag sortedCounts ];
		at: 'allRootClassesAsaSet'
			put:
				[ :aGroupOfScanReports | self computeAllRootClassesAsSetFor: aGroupOfScanReports ];
		at: 'colorsOfRootClasses'
			put:
				[ :aGroupOfScanReports | self computeColorsOfRootClassesFor: aGroupOfScanReports ];
		yourself
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> generateCSVFor: aProject [
	| stream anOutputFileName |
	
	anOutputFileName := aProject, Date today yyyymmdd, Time now hhmm24,'.txt'.
	[ stream := anOutputFileName asFileReference writeStream.
	stream setToEnd.
	stream << 'Project '<< ';' << aProject.
	stream crlf.
	stream << 'numberOfSuffixes'<< ';' << self allSuffixes size asString.
	stream crlf.
	stream << 'numberOfCoherentSuffixes'<< ';' << self allCoherentSuffixes size asString.
	stream crlf.
	stream << 'numberOfMultiClassSuffixes'<< ';' << self allMultiClassSuffixes size asString.
	stream crlf.
	stream << 'numberOfMultiClassCoherentSuffixes'<< ';' << self allMultiClassCoherentSuffixes size asString.
	stream crlf.stream crlf.
	stream << 'numberOfHierarchies'<< ';' << self allHierarchies size asString.
	stream crlf.
	stream << 'numberOfCoherentHierarchies'<< ';' << self allCoherentHierarchies size asString.
	stream crlf.
	stream << 'numberOfMultiClassHierarchies'<< ';' << self allMultiClassHierarchies size asString.
	stream crlf.
	stream << 'numberOfMultiClassCoherentHierarchies'<< ';' << self allMultiClassCoherentHierarchies size asString.
	stream crlf.
	] ensure:[stream close].

anOutputFileName := aProject, 'SuffixReport', Date today yyyymmdd, '_', Time now hhmm24,'.txt'.
	[ stream := anOutputFileName asFileReference writeStream.
	stream setToEnd.
	stream << 'suffix;isUsedInManyHierarchies;isFalsePositive;isTrueAmbiguous;note;canBeFixedConformingToUnicityHypothesis'.
	stream crlf.
self allSuffixes do: [ :aSuffixScanReport| 
		aSuffixScanReport value saveTo: stream].
	] ensure:[stream close].
anOutputFileName := aProject, 'HierarchiesReport', Date today yyyymmdd, '_', Time now hhmm24,'.txt'.
	[ stream := anOutputFileName asFileReference writeStream.
	stream setToEnd.
	stream << 'Hierarchy;HIERARHCY_usesManySuffixes;HIERARHCY_isFalsePositive;HIERARHCY_isNamedInconsistently;HIERARHCY_noteOnCoherence;HIERARHCY_canBeFixedConformingToUnicityHypothesis'.
	stream crlf.
self allHierarchies do: [ :aHierarchyScanReport| 
		aHierarchyScanReport value saveTo: stream].
	] ensure:[stream close].
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> groupOfPackagesScanReport [
	^ self classNamesScanReport
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> initialize [
	super initialize.
	availableColors := self class allColors
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> pickAnAvailableColorNumber: indexOfColors [
"Color grey: 1 is used for Meta Root classes"
	indexOfColors <= (availableColors size) ifTrue:[^availableColors at: indexOfColors]
	ifFalse:[ ^Color gray: indexOfColors / (availableColors size) ]
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> saveInMooseModel: aDictionaryOfColors [
	self scannedPackages mooseModel dictionaryOfRootClassColors: aDictionaryOfColors.
	^aDictionaryOfColors
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> scannedPackages [
	^ self scannedEntities
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> scannedPackages: aFAMIXPackageGroup [ 
	self scannedEntities: aFAMIXPackageGroup 
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> subEntities [
	^self scannedPackages.
]
