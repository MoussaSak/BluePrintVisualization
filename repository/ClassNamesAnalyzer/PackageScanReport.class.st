Class {
	#name : #PackageScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Core'
}

{ #category : #accessing }
PackageScanReport >> classScanReports [
	^self subEntityScanReports
]

{ #category : #accessing }
PackageScanReport >> classScanReports: aGoupOfReports [
	^self subEntityScanReports: aGoupOfReports
]

{ #category : #sorting }
PackageScanReport >> sortSuffixes: unSortedSuffixes [ 
|colorClusters temp result|
result := OrderedCollection new.
temp := unSortedSuffixes.
colorClusters := Dictionary new.
temp do:[:aSuffix| colorClusters at: (aSuffix value dominantHierarchieInPackage: self scannedEntity) "key first" ifPresent: [(colorClusters at:(aSuffix value dominantHierarchieInPackage: self scannedEntity)) add: aSuffix value] ifAbsentPut: (OrderedCollection with: aSuffix value)].

colorClusters do:[:anArray| anArray sort: [:first :second| 
		(((first packagesWithClasses at: self scannedEntity) detect: [ :each | (each at: 'isRoot')] ifNone: [ nil ]) isNotNil ) 
		or:(first packagesWithClasses at: self scannedEntity) size > (second packagesWithClasses at: self scannedEntity) size ]].

(colorClusters values sort: [ :first :second | first size > second size ]) do:[:anArray| result addAll: anArray].
^result
]
