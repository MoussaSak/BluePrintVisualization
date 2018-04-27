Class {
	#name : #PackageScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #'as yet unclassified' }
PackageScanReport >> classScanReports [
	^self subEntityScanReports
]

{ #category : #'as yet unclassified' }
PackageScanReport >> classScanReports: aGoupOfReports [
	^self subEntityScanReports: aGoupOfReports
]
