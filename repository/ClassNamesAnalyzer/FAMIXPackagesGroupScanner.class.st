Class {
	#name : #FAMIXPackagesGroupScanner,
	#superclass : #VocabularyScanner,
	#instVars : [
		'availableColors'
	],
	#category : #ClassNamesAnalyzer
}

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> allColors [
	^(((Color colorNamesXKCD collect:#second) reject: [ :each|each size<3 ] )collect: [ :each|
	Color fromRgbTriplet: each ])
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> reportClass [
	^GroupOfPackagesScanReport
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner class >> scan: aFAMIXPackageGroup [ 
	"^(self new scannedEntities: aFAMIXPackageGroup) generateaClassNamesScanReport;yourself."
	^super scan: aFAMIXPackageGroup 
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages' put: [ :aGroupOfScanReports | aGroupOfScanReports size ];
		at: 'allClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allClasses']  ];
		at: 'classNames' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'classNames']];
		at: 'allRootClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allRootClasses']];
		
		at: 'hierarchiesGroupedBySuffixes' put: [ :aGroupOfScanReports | 
			|aDictionary|
			aDictionary := Dictionary new.
(self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) collect: [:association|
	|suffix rootClass|
	suffix := association value at: 'classSuffix'.
	rootClass := association key.
	aDictionary at: suffix ifPresent: [(aDictionary at: suffix) add: rootClass ] ifAbsentPut: [Bag with: rootClass] ].
	aDictionary];

		at: 'dominantRootsInSuffix' put: [ :aGroupOfScanReports | 
			((self classNamesScanReport at: 'hierarchiesGroupedBySuffixes' ifAbsentPut: [(self defaultMetrics at:'hierarchiesGroupedBySuffixes') value: aGroupOfScanReports])associations collect: [:association|association key -> association value sortedCounts])asDictionary];


		at: 'suffixesGroupedByRootClasses' put: [ :aGroupOfScanReports | 
			|aDictionary|
			aDictionary := Dictionary new.
(self classNamesScanReport at: 'allClassesGroupedByRootClasses' ifAbsentPut: [(self defaultMetrics at:'allClassesGroupedByRootClasses') value: aGroupOfScanReports]) associations collect: [:association|
	association key -> (association value collect: [:aReport| aReport at: 'classSuffix'])
	]];
		
		
		at: 'allClassesGroupedByRootClasses' put: [ :aGroupOfScanReports | 
			|aDictionary|
			aDictionary := Dictionary new.
			(self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) do:[:anAssociation|
				|root subClass|
				root := anAssociation key.
				subClass := anAssociation value.
				aDictionary at: root ifPresent: [ (aDictionary at: root) add: subClass;yourself ] ifAbsentPut: [ Bag with: subClass ]
			
				].
			aDictionary];
		
		at: 'allRootClassesSortedByNumberOfSubClasses' put: [ :aGroupOfScanReports | ((self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) collect:#key) asBag sortedCounts];
		
		at: 'allRootClassesAsaSet' put: [ :aGroupOfScanReports | (self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClassesSortedByNumberOfSubClasses') value: aGroupOfScanReports] ) collect: #value ];
		
		at: 'colorsOfRootClasses' put: [ :aGroupOfScanReports | 
			|aDictionaryOfColors i|
			i := 0.
			aDictionaryOfColors := Dictionary new.
			(self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClassesSortedByNumberOfSubClasses') value: aGroupOfScanReports] ) do: [ :aRootClass| i:= i+1. aDictionaryOfColors at: aRootClass value put: (self pickAnAvailableColorNumber: i) ]. self saveInMooseModel: aDictionaryOfColors ];
		
		yourself
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> groupOfPackagesScanReport [
	^ self classNamesScanReport
]

{ #category : #accessing }
FAMIXPackagesGroupScanner >> initialize [
	super initialize.
	availableColors := self class allColors
]

{ #category : #VocabularyScanning }
FAMIXPackagesGroupScanner >> mergeSinglePackageScanReports: aCollectionOfPackageScanReports [ 
	self 
		deprecated: 'Use generateaClassNamesScanReport instead'
		on: 	'27 April 2018' 
		in: 'Pharo-5.0-50761-'.
	^ self generateaClassNamesScanReport 
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> pickAnAvailableColorNumber: indexOfColors [
	indexOfColors < (availableColors size) ifTrue:[^availableColors at: indexOfColors]
	ifFalse:[ ^Color gray: indexOfColors / (availableColors size) ]
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> saveInMooseModel: aDictionaryOfColors [
	self scannedPackages mooseModel dictionaryOfRootClassColors: aDictionaryOfColors.
	^aDictionaryOfColors
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
