Class {
	#name : #VocabularyScanReport,
	#superclass : #Dictionary,
	#instVars : [
		'subEntityScanReports',
		'scannedEntity'
	],
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #accessing }
VocabularyScanReport >> = aReport [
	self flag: #tofix. "There is a problem in the model. There is a key that is not found in a dictionary or set."
	aReport = 'KeyForNilObjects'
		ifTrue: [ ^ false ].
	^ aReport
		ifNotNil: [ scannedEntity = aReport scannedEntity ]
		ifNil: [ false ]
]

{ #category : #accessing }
VocabularyScanReport >> hash [
	^ scannedEntity hash
]

{ #category : #accessing }
VocabularyScanReport >> scannedEntity [
	^ scannedEntity
]

{ #category : #accessing }
VocabularyScanReport >> scannedEntity: aFAMIXPackageGroup [ 
	scannedEntity := aFAMIXPackageGroup
]

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports [
	^ subEntityScanReports
]

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports: aMooseGroup [ 
	subEntityScanReports := aMooseGroup
]
