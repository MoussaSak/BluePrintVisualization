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
	^(self new scannedEntities: aFAMIXPackageGroup) generateaClassNamesScanReport.
]

{ #category : #metrics }
VocabularyScanner >> addaMetric: metricName with: aBlock [
	definedMetrics at: metricName put: aBlock
	
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

{ #category : #VocabularyScanning }
VocabularyScanner >> generateaClassNamesScanReport [
	| subEntityScanReports |
	classNamesScanReport := self reportClass new.
	subEntityScanReports := self subEntities collect: #scanClassNames.
	classNamesScanReport subEntityScanReports: subEntityScanReports.
	self definedMetrics associations do:[:each| 
		classNamesScanReport at: each key put: (each value value: (subEntityScanReports))".self halt"].
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
