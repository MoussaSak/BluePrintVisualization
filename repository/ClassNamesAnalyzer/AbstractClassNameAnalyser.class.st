"
I'm an analyser. I analyse classes, package or groups of packages and I create object representing my name analysis. 
In addition I'm reponsible for drawing visualisation that use the report objects I created.
"
Class {
	#name : #AbstractClassNameAnalyser,
	#superclass : #Object,
	#instVars : [
		'scannedEntities',
		'definedMetrics',
		'showInheritanceRelationships',
		'report'
	],
	#category : #'ClassNamesAnalyzer-Core'
}

{ #category : #'instance-creation' }
AbstractClassNameAnalyser class >> reportClass [
	^self subclassResponsibility
]

{ #category : #'instance-creation' }
AbstractClassNameAnalyser class >> scan: aFAMIXPackageGroup [
 
	| aVocabularyAnalyser |
	aVocabularyAnalyser := (self new scannedEntities: aFAMIXPackageGroup) generateClassNamesScanReport; yourself.
	aFAMIXPackageGroup vocabularyScanner: aVocabularyAnalyser.
	^ aVocabularyAnalyser
]

{ #category : #metrics }
AbstractClassNameAnalyser >> addMetric: metricName with: aBlock [
	definedMetrics at: metricName put: aBlock
	
]

{ #category : #metrics }
AbstractClassNameAnalyser >> allClassNameSuffixesSorted: suffixScanReports [

	| agregatedSuffixScanReports |
	agregatedSuffixScanReports := OrderedCollection new.
				[suffixScanReports notEmpty] whileTrue: [ 
				|aSuffixDescriptor descriptorsOfSameSuffix indexesOfDescriptorsOfSameSuffix| 
				indexesOfDescriptorsOfSameSuffix := OrderedCollection new.
				aSuffixDescriptor := suffixScanReports first.
				suffixScanReports removeFirst.
				1 to: suffixScanReports size do: [:index| (((suffixScanReports at:index) suffix) = aSuffixDescriptor suffix) ifTrue: [indexesOfDescriptorsOfSameSuffix add: index]].
				descriptorsOfSameSuffix := indexesOfDescriptorsOfSameSuffix collect: [ :i| suffixScanReports at: i ].
				
				aSuffixDescriptor mergeWith: descriptorsOfSameSuffix.
				"aSuffixDescriptor at: #suffix put: aSuffixDescriptor suffix."
				agregatedSuffixScanReports add: aSuffixDescriptor.
				
							indexesOfDescriptorsOfSameSuffix reversed do: [:i| suffixScanReports removeAt: i]
				]. 
				agregatedSuffixScanReports sort: [:first :second| first numberOfClasses > second numberOfClasses].
				^agregatedSuffixScanReports collect: [ :each| each numberOfClasses->each  ].

]

{ #category : #visualisations }
AbstractClassNameAnalyser >> classBluePrint [

	^ report
		at: 'classBlueprint'
		ifAbsentPut: [ self computeClassBlueprint ]
]

{ #category : #accessing }
AbstractClassNameAnalyser >> classNamesScanReport [
	^ report
]

{ #category : #compute }
AbstractClassNameAnalyser >> computeClassBlueprint [
	| sortedRootClasses b |
	b := RTMondrian new.
	sortedRootClasses := (self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses') collect: #value.
	b shape rectangle withTextAbove.
	b
		nodes: self scannedPackages
		forEach: [ :aSinglePackage | 
			| aSinglePackageScanReport sortedSuffixes unSortedSuffixes |
			aSinglePackageScanReport := aSinglePackage vocabularyScanner
				classNamesScanReport.
			b shape rectangle.
			b shape
				color: [ :aSuffix | 
					| dominantClasse |
					dominantClasse := ((self groupOfPackagesScanReport
						at: 'dominantRootsInSuffix') at: aSuffix value suffix) first
						value.
					"if DictionaryOfColors is nil this means that the group of packages has not been scanned yet. Then scan it"
					self dictionaryOfColors
						ifNil: [ self scannedEntities mooseModel allPackages nameAnalyser ].
					(self dictionaryOfColors at: dominantClasse)
						adjustGray: aSuffix hierarchies asSet size	"alpha: ((aSuffix value dominantHierarchieInPackages select: [ :each| each value >= aSuffix value dominanceLevel ]) size / aSuffix value dominantHierarchieInPackages size)" ];
				withTextAbove: [ :each | each value suffix ];
				borderWidth: 2.
			b shape
				borderColor: [ :aSuffix | 
					| dominantClasse |
					dominantClasse := ((self groupOfPackagesScanReport
						at: 'dominantRootsInSuffix') at: aSuffix value suffix) first
						value.
					self dictionaryOfColors at: dominantClasse ].
			unSortedSuffixes := (self groupOfPackagesScanReport
				at: 'allClassNameSuffixesSorted')
				select: [ :association | 
					association value packages
						includes: aSinglePackageScanReport scannedEntity ].
			"sortedSuffixes := sortedSuffixes sort: [ :first :second | (first value dominantHierarchie key first = second value dominantHierarchie key first) and: ].
"
			sortedSuffixes := aSinglePackageScanReport
				sortSuffixes: unSortedSuffixes.
			b
				nodes: sortedSuffixes
				forEach: [ :suffix | 
					b shape rectangle.
					b shape
						size:
							[ :aClassScanReport | 50 / ((aClassScanReport at: 'superclassesInCurrentPackage') size + 1) ].
					b shape
						color:
								[ :aClassScanReport | self dictionaryOfColors at: (aClassScanReport at: 'rootClass') ];
						borderColor: [ :aClassScanReport | 
							(aClassScanReport at: 'className')
								= (aClassScanReport at: 'rootClass') name
								ifTrue: [ Color black ]
								ifFalse: [ (self dictionaryOfColors at: (aClassScanReport at: 'rootClass'))
										adjustBrightness: -0.1 ] ];
						borderWidth: 1.
					b
						nodes:
							((aSinglePackageScanReport at: 'classesGroupedBySuffixes')
								at: suffix value suffix).
					b layout grid ].
			b layout grid ].
	b layout grid.
	b view elements
		do: [ :element | 
			element announcer subscriptions subscriptions
				do: [ :each | element announcer subscriptions subscriptions remove: each ] ].
	"b view elements do: [ :element| element @ (element model mouseAnnouncer)]"
	b shape line color: (Color white alpha: 0.05).
	showInheritanceRelationships
		ifTrue: [ self displayInheritanceRelationsOn: b ].
	^ b
]

{ #category : #'vocabulary scanning' }
AbstractClassNameAnalyser >> computeReportsForSubEntities [

	^ self subEntities collect: [ :each |  each nameAnalyser classNamesScanReport]

]

{ #category : #initialization }
AbstractClassNameAnalyser >> defaultMetrics [
	^ self subclassResponsibility 
]

{ #category : #metrics }
AbstractClassNameAnalyser >> definedMetricNames [
	^ definedMetrics allKeys
	
]

{ #category : #metrics }
AbstractClassNameAnalyser >> definedMetrics [
	^ definedMetrics
	
]

{ #category : #utils }
AbstractClassNameAnalyser >> dictionaryOfColors [

	^ self scannedEntities mooseModel dictionaryOfRootClassColors
]

{ #category : #compute }
AbstractClassNameAnalyser >> displayInheritanceRelationsOn: b [ 

	b edges: ((self classNamesScanReport at: 'allClasses') collect: [ :each | each vocabularyScanner classNamesScanReport ])
		from: #yourself
		to: [ :aClassScanReport |
				(aClassScanReport at: 'superclasse')
					ifNotNil: [ (aClassScanReport at: 'superclasse') vocabularyScanner classNamesScanReport ] ].
]

{ #category : #'vocabulary scanning' }
AbstractClassNameAnalyser >> generateClassNamesScanReport [
	| subEntityScanReports |
	
	report := self reportClass new.
	report scannedEntity: scannedEntities.
	
	subEntityScanReports := self computeReportsForSubEntities.
	report subEntityScanReports: subEntityScanReports.
	
	"Here we compute the value of the state of the whole based on the subelement values"
	self definedMetrics associations 
		do: [ :each | 
				report 
					at: each key 
					ifAbsentPut: (each value value: subEntityScanReports)].
	^ report.

]

{ #category : #initialization }
AbstractClassNameAnalyser >> initialize [
	super initialize.
	definedMetrics := self defaultMetrics.
	showInheritanceRelationships := false
]

{ #category : #metrics }
AbstractClassNameAnalyser >> removeMetrics: metricName [
	definedMetrics removeKey: metricName ifAbsent: [  ]
	
]

{ #category : #accessing }
AbstractClassNameAnalyser >> reportClass [
	^self class reportClass
]

{ #category : #accessing }
AbstractClassNameAnalyser >> scannedEntities [
	^ scannedEntities
]

{ #category : #accessing }
AbstractClassNameAnalyser >> scannedEntities: aFAMIXClassOrPackageOrPackageGroup [ 
	scannedEntities := aFAMIXClassOrPackageOrPackageGroup
]
