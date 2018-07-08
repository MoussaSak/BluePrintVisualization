Class {
	#name : #GroupOfPackagesScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #accessing }
GroupOfPackagesScanReport >> at: key ifAbsent: aBlock [ 
	"self halt."
	^super at: key ifAbsent: aBlock 
]

{ #category : #accessing }
GroupOfPackagesScanReport >> singlePackageScanReports [
	^ self subEntityScanReports
]

{ #category : #accessing }
GroupOfPackagesScanReport >> singlePackageScanReports: aGroupOfReports [
	self subEntityScanReports: aGroupOfReports
]
