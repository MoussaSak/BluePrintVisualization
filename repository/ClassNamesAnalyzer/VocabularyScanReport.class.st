Class {
	#name : #VocabularyScanReport,
	#superclass : #Dictionary,
	#instVars : [
		'subEntityScanReports'
	],
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports [
	^ subEntityScanReports
]

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports: aMooseGroup [ 
	subEntityScanReports := aMooseGroup
]
