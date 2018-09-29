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

{ #category : #queries }
FAMIXPackagesGroupScanner >> allCoherentHierarchies [
	^self allHierarchies select: [:each | each allHierarchySuffixes size = 1].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allCoherentSuffixes [
	^self allSuffixes select: [ :each | each value hierarchies asSet size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allHierarchies [
	^(self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses') collect: [ :each | each value classNamesScanReport ].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allInCoherentSuffixes [
	^self allSuffixes select:  [ :each| each value hierarchies asSet size > 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allIncoherentHierarchies [
	^self allHierarchies select: [:each | each allHierarchySuffixes size > 1].
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassCoherentHierarchies [
	^self allMultiClassHierarchies select: [ :each| each allHierarchySuffixes size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassCoherentSuffixes [
	^self allMultiClassSuffixes select: [ :each| each value hierarchies asSet size = 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassHierarchies [
	^self allHierarchies select: [ :each | each scannedEntity allSubInheritances size >= 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allMultiClassSuffixes [
	^self allSuffixes select: [ :each | each key > 1 ]
]

{ #category : #queries }
FAMIXPackagesGroupScanner >> allSuffixes [
	^self classNamesScanReport at: 'allClassNameSuffixesSorted'.
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> defaultMetrics [
	^ Dictionary new
		at: 'numberOfPackages' put: [ :aGroupOfScanReports | aGroupOfScanReports size ];
		at: 'allClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allClasses']  ];
		at: 'classNames' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'classNames']];
		at: 'allRootClasses' put: [ :aGroupOfScanReports | aGroupOfScanReports flatCollect: [ :aPackageScanReport| aPackageScanReport at: 'allRootClasses']];
		
				at: 'hierarchiesGroupedBySuffixes' put: [ :aGroupOfScanReports | 
					((self classNamesScanReport at: 'allClassNameSuffixesSorted' ifAbsentPut: [(self defaultMetrics at:'allClassNameSuffixesSorted') value: aGroupOfScanReports]) collect: [:association|
						association value suffix->association value hierarchies]) asDictionary
					];

		
		at: 'allClassNameSuffixesSorted' put: [ :aGroupOfScanReports | 
			|suffixScanReports|
			suffixScanReports := ((self classNamesScanReport subEntityScanReports collect: [ :aPackageScanReport|  aPackageScanReport at: 'allClassNameSuffixesSorted']) flatCollect: #value)collect: #value.
			self allClassNameSuffixesSorted: suffixScanReports.
			
			"|aDictionary|
			aDictionary := Dictionary new.
(self classNamesScanReport at: 'allRootClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClasses') value: aGroupOfScanReports]) collect: [:association|
	|suffix rootClass|
	suffix := association value at: 'classSuffix'.
	rootClass := association key.
	aDictionary at: suffix ifPresent: [(aDictionary at: suffix) add: rootClass ] ifAbsentPut: [Bag with: rootClass] ].
	aDictionary"];

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
			self scannedEntities mooseModel dictionaryOfRootClassColors ifNil:
			[|aDictionaryOfColors i|
			i := 0.
			aDictionaryOfColors := Dictionary new.
			
			(self classNamesScanReport at: 'allRootClassesSortedByNumberOfSubClasses' ifAbsentPut: [(self defaultMetrics at:'allRootClassesSortedByNumberOfSubClasses') value: aGroupOfScanReports] ) do: [ :aRootClass| aRootClass value isMetaRoot ifTrue: [aDictionaryOfColors at: aRootClass value put: (Color gray: 1) ] ifFalse: [ i:= i+1. aDictionaryOfColors at: aRootClass value put: (self pickAnAvailableColorNumber: i) ]. self saveInMooseModel: aDictionaryOfColors ]]];
		
		yourself
]

{ #category : #'instance-creation' }
FAMIXPackagesGroupScanner >> generateSVNFor: aProject [
	| aString |
	aString := 'Project : ;', aProject,
	String cr,
	'numberOfSuffixes ;', self allSuffixes size asString,
	String cr,
	'numberOfCoherentSuffixes ;', self allCoherentSuffixes size asString,
	String cr,
	'numberOfMultiClassSuffixes ;', self allMultiClassSuffixes size asString,
	String cr,
	'numberOfMultiClassCoherentSuffixes ;', self allMultiClassCoherentSuffixes size asString,
	(String cr;cr),
	'numberOfHierarchies :', self allHierarchies size asString,
	String cr,
	'numberOfCoherentHierarchies : ', self allCoherentHierarchies size asString,
	String cr,
	'numberOfMultiClassHierarchies: ', self allMultiClassHierarchies size asString,
	'numberOfMultiClassCoherentHierarchies: ', self allMultiClassCoherentHierarchies size asString
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
"Color grey: 1 is used for Meta Root classes"
	indexOfColors <= (availableColors size) ifTrue:[^availableColors at: indexOfColors]
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
