Class {
	#name : #FAMIXPackageScanner,
	#superclass : #VocabularyScanner,
	#category : #ClassNamesAnalyzer
}

{ #category : #'as yet unclassified' }
FAMIXPackageScanner class >> reportClass [
	^PackageScanReport
]

{ #category : #'as yet unclassified' }
FAMIXPackageScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages' put: [:argh| 1];
		at: 'allClasses' put: [ :aSingleClassScanReports | aSingleClassScanReports collect: #scannedClass];
		at: 'classNames' put: [ :aSingleClassScanReports | aSingleClassScanReports collect:  [:aPackageScanReport| aPackageScanReport at: 'className']];
		at: 'allClassNameSuffixes' put: [ :aSingleClassScanReports | aSingleClassScanReports collect:  [:aPackageScanReport| aPackageScanReport at: 'classSuffix']];
		at: 'allRootClasses' put: [ :aSingleClassScanReports | aSingleClassScanReports collect:  [:aPackageScanReport| aPackageScanReport at: 'rootClass']];
		at: 'allRootClassesAsaSet' put: [ :aSingleClassScanReports | (self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aSingleClassScanReports]) asSet ];
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
