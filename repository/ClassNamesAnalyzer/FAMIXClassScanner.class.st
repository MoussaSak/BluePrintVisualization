Class {
	#name : #FAMIXClassScanner,
	#superclass : #VocabularyScanner,
	#category : #'ClassNamesAnalyzer-Core'
}

{ #category : #'as yet unclassified' }
FAMIXClassScanner class >> reportClass [
	^ClassScanReport
]

{ #category : #'as yet unclassified' }
FAMIXClassScanner >> computeRootClassFor: aFAMIXClassScanner [
	^ (self computeSuperClassesOf: aFAMIXClassScanner) first
]

{ #category : #'as yet unclassified' }
FAMIXClassScanner >> computeSuperClassesOf: aFAMIXClassScanner [
	^ (aFAMIXClassScanner classNamesScanReport
		at: 'superclasses'
		ifAbsentPut: [ (self defaultMetrics at: 'superclasses') value: aFAMIXClassScanner ])
		
]

{ #category : #'as yet unclassified' }
FAMIXClassScanner >> defaultMetrics [
	"use 'aFAMIXClassScanner classNamesScanReport' whenever an expensive computation is required and has been computed in a previous metric
	Example : rootClass uses the metric superclasses"

	^ Dictionary new
		at: 'scannedClasses'
			put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass ];
		at: 'className'
			put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass name ];
		at: 'classSuffix'
			put:
				[ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass name suffixWithCamelCase ];
		at: 'superclasses'
			put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass superclasses ];
		at: 'package'
			put:
				[ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass parentPackage ];
		at: 'superclassesInCurrentPackage'
			put: [ :aFAMIXClassScanner | 
			(aFAMIXClassScanner classNamesScanReport
				at: 'superclasses'
				ifAbsentPut: [ (self defaultMetrics at: 'superclasses') value: aFAMIXClassScanner ])
				select: [ :aFamixPackage | 
					aFamixPackage parentPackage
						= aFAMIXClassScanner scannedClass parentPackage ] ];
		at: 'superclasse'
			put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass superclass ];
		at: 'rootClass'
			put: [ :aFAMIXClassScanner | self computeRootClassFor: aFAMIXClassScanner  ];
		at: 'isRoot'
			put: [ :aFAMIXClassScanner | scannedEntities isaRootClass ];
		at: 'isMetaRoot'
			put: [ :aFAMIXClassScanner | scannedEntities isMetaRoot ];
		yourself
]

{ #category : #VocabularyScanning }
FAMIXClassScanner >> generateClassNamesScanReport [
	classNamesScanReport := ClassScanReport new.
	classNamesScanReport scannedEntity: scannedEntities.
	self definedMetrics associations do:[:each| classNamesScanReport at: each key ifAbsentPut: (each value value: self)].
	^classNamesScanReport
]

{ #category : #accessing }
FAMIXClassScanner >> scannedClass [
	^ self scannedEntities
]

{ #category : #accessing }
FAMIXClassScanner >> scannedClass: aFAMIXClass [ 
	self scannedEntities: aFAMIXClass 
]
