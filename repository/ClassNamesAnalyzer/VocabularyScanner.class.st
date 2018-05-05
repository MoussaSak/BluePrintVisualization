Class {
	#name : #VocabularyScanner,
	#superclass : #Object,
	#instVars : [
		'classNamesScanReport',
		'scannedEntities',
		'definedMetrics'
	],
	#category : #ClassNamesAnalyzer
}

{ #category : #'as yet unclassified' }
VocabularyScanner class >> defaultMetrics [
	^self subclassResponsibility
]

{ #category : #'instance-creation' }
VocabularyScanner class >> reportClass [
	^self subclassResponsibility
]

{ #category : #'instance-creation' }
VocabularyScanner class >> scan: aFAMIXPackageGroup [ 
	|aVocabularyScanner|
	aVocabularyScanner := (self new scannedEntities: aFAMIXPackageGroup) generateaClassNamesScanReport;yourself.
	aFAMIXPackageGroup vocabularyScanner: aVocabularyScanner.
	^aVocabularyScanner
]

{ #category : #metrics }
VocabularyScanner >> addaMetric: metricName with: aBlock [
	definedMetrics at: metricName put: aBlock
	
]

{ #category : #Visualizations }
VocabularyScanner >> classBluePrint [
		| b sortedRootClasses dictionaryOfColors|
	^classNamesScanReport at: 'classBlueprint' ifAbsentPut:[	b := RTMondrian new.
	sortedRootClasses := (self classNamesScanReport
		at: 'allRootClassesSortedByNumberOfSubClasses') collect: #value.
	dictionaryOfColors := self classNamesScanReport
		at: 'colorsOfRootClasses'.
	b shape rectangle withTextAbove.
	b
		nodes: self scannedPackages
		forEach: [ :aSinglePackage | 
			| aSinglePackageScanReport |
			aSinglePackageScanReport := aSinglePackage vocabularyScanner
				classNamesScanReport.
			b shape rectangle.
			b shape
				color: [ :aSuffix | 
					| dominantClasse |
					dominantClasse := ((self classNamesScanReport
						at: 'dominantRootsInSuffix') at: aSuffix value) first value.
					self dictionaryOfColors at: dominantClasse ];
				withTextAbove: #value.
			b
				nodes: (aSinglePackageScanReport at: 'allClassNameSuffixesSorted')
				forEach: [ :suffix | 
					b shape: RTEllipse new.
					b shape
						size:
							[ :aClassScanReport | 50 / (aClassScanReport at: 'superclasses') size ].
					b shape
						color: [ :aClassScanReport | 
							(aClassScanReport at: 'className') = 'Object'
								ifTrue: [ Color black ]
								ifFalse: [ self dictionaryOfColors at: (aClassScanReport at: 'rootClass') ] ];
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
								at: suffix value).
					b edges
						connectFrom: [ :aClassScanReport | (aClassScanReport at: 'superclasse') vocabularyScanner classNamesScanReport].
					b layout grid ].
			b layout grid ].
	b layout grid.
	
	
	b view elements do: [ :element| element announcer subscriptions  subscriptions do: [ :each | element announcer subscriptions  subscriptions remove: each ]].
	b view elements do: [ :element| element @ (element model mouseAnnouncer)].
	b edges view edges do: [ :each| each color: ((each from color adjustBrightness: -0.1) alpha: 0.1) ].
	
	^ b build]
]

{ #category : #Accessing }
VocabularyScanner >> classNamesScanReport [
	^ classNamesScanReport
]

{ #category : #metrics }
VocabularyScanner >> definedMetricNames [
	^definedMetrics allKeys
	
]

{ #category : #metrics }
VocabularyScanner >> definedMetrics [
	^definedMetrics
	
]

{ #category : #'instance-creation' }
VocabularyScanner >> dictionaryOfColors [
	^self scannedEntities mooseModel dictionaryOfRootClassColors
]

{ #category : #VocabularyScanning }
VocabularyScanner >> generateaClassNamesScanReport [
	| subEntityScanReports |
	classNamesScanReport := self reportClass new.
	classNamesScanReport scannedEntity: scannedEntities.
	subEntityScanReports := (self subEntities collect: #scanClassNames) collect: #classNamesScanReport.
	classNamesScanReport subEntityScanReports: subEntityScanReports.
	self definedMetrics associations do:[:each| 
		classNamesScanReport at: each key ifAbsentPut: (each value value: (subEntityScanReports))].
	^classNamesScanReport.

]

{ #category : #initialization }
VocabularyScanner >> initialize [
	super initialize.
	definedMetrics := self defaultMetrics.
]

{ #category : #metrics }
VocabularyScanner >> removeaMetrics: metricName [
	definedMetrics removeKey: metricName ifAbsent: [  ]
	
]

{ #category : #accessing }
VocabularyScanner >> reportClass [
	^self class reportClass
]

{ #category : #accessing }
VocabularyScanner >> scannedEntities [
	^ scannedEntities
]

{ #category : #accessing }
VocabularyScanner >> scannedEntities: aFAMIXClassOrPackageOrPackageGroup [ 
	scannedEntities := aFAMIXClassOrPackageOrPackageGroup
]
