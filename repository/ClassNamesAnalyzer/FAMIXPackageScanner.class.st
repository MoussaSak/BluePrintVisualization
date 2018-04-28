Class {
	#name : #FAMIXPackageScanner,
	#superclass : #VocabularyScanner,
	#category : #ClassNamesAnalyzer
}

{ #category : #'as yet unclassified' }
FAMIXPackageScanner class >> reportClass [
	^PackageScanReport
]

{ #category : #accessing }
FAMIXPackageScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages' put: [ :argh | 1 ];
		at: 'allClasses' put: [ :aSingleClassScanReports | aSingleClassScanReports collect: #scannedClass ];
		at: 'classNames'
			put:
				[ :aSingleClassScanReports | aSingleClassScanReports collect: [ :aSingleClassScanReport | aSingleClassScanReport at: 'className' ] ];
		at: 'classesAndSuffixes'
			put: [ :aSingleClassScanReports | 
			aSingleClassScanReports
				collect: [ :aSingleClassScanReport | (aSingleClassScanReport scannedClass) -> (aSingleClassScanReport at: 'classSuffix') ] ];
			
		at: 'rootClassesGroupedBySuffixes'
			put: [ :aSingleClassScanReports | 
			| classesGroupedBySuffixes |
			
			classesGroupedBySuffixes := self classNamesScanReport
				at: 'classesGroupedBySuffixes'
				ifAbsentPut: [ (self defaultMetrics at: 'classesGroupedBySuffixes') value: aSingleClassScanReports ].
			classesGroupedBySuffixes associations collect: [:anAssociation| (anAssociation key -> (anAssociation value collect: #rootClass))]
				  ]	;
			
		at: 'classesGroupedBySuffixes'
			put: [ :aSingleClassScanReports | 
			| aDictionary classNamesAndSuffixes |
			aDictionary := Dictionary new.
			classNamesAndSuffixes := self classNamesScanReport
				at: 'classesAndSuffixes'
				ifAbsentPut: [ (self defaultMetrics at: 'classesAndSuffixes') value: aSingleClassScanReports ].
			classNamesAndSuffixes
				do: [ :anAssociation | 
					|aSuffix aClass|
					aSuffix := anAssociation value.
					aClass := anAssociation key.
					aDictionary
						at: aSuffix
						ifPresent: [ aDictionary
								at: aSuffix
								put:
									((aDictionary at: aSuffix)
										add: aClass;
										yourself) ]
						ifAbsentPut: [ Bag with: aClass ] ].
			aDictionary ];
		at: 'allClassNameSuffixes'
			put:
				[ :aSingleClassScanReports | aSingleClassScanReports collect: [ :aPackageScanReport | aPackageScanReport at: 'classSuffix' ] ];
			
		at: 'allClassNameSuffixesSorted'
			put: [ :aSingleClassScanReports | 
			(self classNamesScanReport
				at: 'allClassNameSuffixes'
				ifAbsentPut: [ (self defaultMetrics at: 'allClassNameSuffixes') value: aSingleClassScanReports ]) asBag
				sortedCounts ];
		at: 'allClassNameSuffixesAsSet'
			put: [ :aSingleClassScanReports | 
			(self classNamesScanReport
				at: 'allClassNameSuffixesSorted'
				ifAbsentPut: [ (self defaultMetrics at: 'allClassNameSuffixesSorted') value: aSingleClassScanReports ])
				collect: #value ];
		at: 'allRootClasses'
			put:
				[ :aSingleClassScanReports | aSingleClassScanReports collect: [ :aSingleClassScanReport | (aSingleClassScanReport at: 'rootClass')->(aSingleClassScanReport at: 'scannedClasses') ] ];
		at: 'allRootClassesAsaSet'
			put: [ :aSingleClassScanReports | 
			(self classNamesScanReport
				at: 'allRootClasses'
				ifAbsentPut: [ (self defaultMetrics at: 'allRootClasses') value: aSingleClassScanReports ]) asSet ];
		yourself
]

{ #category : #accessing }
FAMIXPackageScanner >> scannedPackage [
	^ self scannedEntities
]

{ #category : #accessing }
FAMIXPackageScanner >> scannedPackage: aFAMIXPackage [ 
	self scannedEntities: aFAMIXPackage
]

{ #category : #accessing }
FAMIXPackageScanner >> subEntities [
	^self scannedPackage classes
]
