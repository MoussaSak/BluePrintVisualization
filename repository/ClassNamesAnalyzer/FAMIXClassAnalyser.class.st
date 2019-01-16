"
I analyze Class names, i am specialied in handling class names.
"
Class {
	#name : #FAMIXClassAnalyser,
	#superclass : #AbstractClassNameAnalyser,
	#category : #'ClassNamesAnalyzer-Core'
}

{ #category : #'as yet unclassified' }
FAMIXClassAnalyser class >> reportClass [
	^ClassScanReport
]

{ #category : #'as yet unclassified' }
FAMIXClassAnalyser >> computeRootClassFor: aFAMIXClassScanner [
	^ (self computeSuperClassesOf: aFAMIXClassScanner) first
]

{ #category : #'as yet unclassified' }
FAMIXClassAnalyser >> computeSuperClassesOf: aFAMIXClassScanner [
	^ (aFAMIXClassScanner classNamesScanReport
		at: 'superclasses'
		ifAbsentPut: [ (self defaultMetrics at: 'superclasses') value: aFAMIXClassScanner ])
		
]

{ #category : #'as yet unclassified' }
FAMIXClassAnalyser >> defaultMetrics [
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
															aFamixPackage parentPackage = aFAMIXClassScanner scannedClass parentPackage ] ];
		at: 'superclasse'
			put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass superclass ];
		at: 'rootClass'
			put:
				[ :aFAMIXClassScanner | self computeRootClassFor: aFAMIXClassScanner ];
		at: 'isRoot'
			put: [ :aFAMIXClassScanner | scannedEntities isaRootClass ];
		at: 'isMetaRoot'
			put: [ :aFAMIXClassScanner | scannedEntities isMetaRoot ];
		yourself
]

{ #category : #VocabularyScanning }
FAMIXClassAnalyser >> generateClassNameReport [
	report := self reportClass new.
	report scannedEntity: scannedEntities.
	self definedMetrics associations
		do: [ :each | report at: each key ifAbsentPut: (each value value: self) ].
	^ report
]

{ #category : #VocabularyScanning }
FAMIXClassAnalyser >> generateClassNamesScanReport [
	report := self reportClass new.
	report scannedEntity: scannedEntities.
	self definedMetrics associations
		do: [ :each | report at: each key ifAbsentPut: (each value value: self) ].
	^ report
]

{ #category : #accessing }
FAMIXClassAnalyser >> scannedClass [
	^ self scannedEntities
]

{ #category : #accessing }
FAMIXClassAnalyser >> scannedClass: aFAMIXClass [ 
	self scannedEntities: aFAMIXClass 
]
