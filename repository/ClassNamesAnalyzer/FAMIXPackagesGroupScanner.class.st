Class {
	#name : #FAMIXPackagesGroupScanner,
	#superclass : #VocabularyScanner,
	#category : #ClassNamesAnalyzer
}

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> reportClass [
	^GroupOfPackagesScanReport
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages' put: [ :aGroupOfScanReports | aGroupOfScanReports size ];
		at: 'allClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allClasses']  ];
		at: 'classNames' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'classNames']];
		at: 'allRootClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allRootClasses']];
		
		at: 'allRootClassesSortedByNumberOfSubClasses' put: [ :aGroupOfScanReports | (self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) asBag sortedCounts];
		
		at: 'allRootClassesAsaSet' put: [ :aGroupOfScanReports | (self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClassesSortedByNumberOfSubClasses') value: aGroupOfScanReports] ) collect: #value ];
		yourself
]

{ #category : #VocabularyScanning }
FAMIXPackagesGroupScanner >> mergeSinglePackageScanReports: aCollectionOfPackageScanReports [ 
	self 
		deprecated: 'Use generateaClassNamesScanReport instead'
		on: 	'27 April 2018' 
		in: 'Pharo-5.0-50761-'.
	^ self generateaClassNamesScanReport 
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> scannedPackages [
	^ self scannedEntities
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> scannedPackages: aFAMIXPackageGroup [ 
	self scannedEntities: aFAMIXPackageGroup 
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> subEntities [
	^self scannedPackages.
]
