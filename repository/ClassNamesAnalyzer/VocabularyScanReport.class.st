"
I'm a report for a given kind of entity being a class, a package or a group of packages. 
"
Class {
	#name : #VocabularyScanReport,
	#superclass : #Dictionary,
	#instVars : [
		'subEntityScanReports',
		'scannedEntity'
	],
	#category : #'ClassNamesAnalyzer-Core'
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
VocabularyScanReport >> hashBorkem [
	^ scannedEntity hash
]

{ #category : #accessing }
VocabularyScanReport >> qequal: aReport [
	self flag: #tofix. "There is a problem in the model. There is a key that is not found in a dictionary or set."
	aReport = 'KeyForNilObjects'
		ifTrue: [ ^ false ].
	^ aReport
		ifNotNil: [ scannedEntity = aReport scannedEntity ]
		ifNil: [ false ]
]

{ #category : #accessing }
VocabularyScanReport >> scannedEntity [
	^ scannedEntity
]

{ #category : #accessing }
VocabularyScanReport >> scannedEntity: aFAMIXEntity [
	scannedEntity := aFAMIXEntity
]

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports [
	^ subEntityScanReports
]

{ #category : #accessing }
VocabularyScanReport >> subEntityScanReports: aMooseGroup [ 
	subEntityScanReports := aMooseGroup
]
