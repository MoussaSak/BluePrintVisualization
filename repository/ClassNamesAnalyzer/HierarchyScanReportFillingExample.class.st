"
this class/method is not executable.
it is just inteded to give guidelines on how to update a HierarchyScanReport with manual analysis information
"
Class {
	#name : #HierarchyScanReportFillingExample,
	#superclass : #Object,
	#category : #'ClassNamesAnalyzer-Examples'
}

{ #category : #'as yet unclassified' }
HierarchyScanReportFillingExample >> example1 [
"this class/method is not executable.
it is just inteded to give guidelines on how to update a HierarchyScanReport with manual analysis information"
| aGroupOfPackagesScanReport associations |
associations := aGroupOfPackagesScanReport allIncoherentHierarchies .
associations do: [:each | each value 
	at: 'usesManySuffixes' put: 'YES'; "put yes if the hierarchy uses  more than one suffix"
	at: 'isFalsePositive' put: 'NO'; "put the name of the categorie of the false positive that violates the suffix unicity assumption : specialization, FrenchStyle, ... The false positive means that the hierarchy naming is coherent despite it violates the suffix unicity assumption
	Put NO otherwise "
	at: 'isHyerarchyNamedInconsistently' put: 'YES'; "put NO if the hierarchy uses many suffixes improperly and some classes should be renamed (independently from our assumptions)"
	at: 'noteOnHierarchyCoherence' put: 'some explanation on the disgnisis and how to fix in case of inconsistency'; 
	at: 'canBeFixedConformingToUnicityHypothesis' put: 'Unknown' "Put YES if you beleive that some classes could be renamed conforming to unicity hypothesis"
	].
]

{ #category : #'as yet unclassified' }
HierarchyScanReportFillingExample >> example2 [
"Where self is aFAMIXPAckageGroupScanner :) "
self allCoherentHierarchies do: [:aHierarchy| aHierarchy classesGroupedBySuffixes do: [ :suffixAndClasses|
	suffixAndClasses do: [ :each|
	each at: 'CLASSNAME_usesAdifferentSuffixeThanRoot' put: 'NO'.
	each at: 'CLASSNAME_isFalsePositive' put: ''. 
	each at: 'CLASSNAME_isNamedInconsistently' put: ''.
	each at: 'CLASSNAME_noteOnCoherence' put: ''.
	each at: 'CLASSNAME_canBeFixedConformingToUnicityHypothesis' put: '' ] ] ].

self allIncoherentHierarchies do: [:aHierarchy|
	(aHierarchy classesGroupedBySuffixes at: aHierarchy suffix) do: [ :each|
	each at: 'CLASSNAME_usesAdifferentSuffixeThanRoot' put: 'NO'.
	each at: 'CLASSNAME_isFalsePositive' put: ''. 
	each at: 'CLASSNAME_isNamedInconsistently' put: ''.
	each at: 'CLASSNAME_noteOnCoherence' put: ''.
	each at: 'CLASSNAME_canBeFixedConformingToUnicityHypothesis' put: '' . ]
].
"edit it one by one"
((self classNamesScanReport at: 'allClasses') collect: [ :each | (each classNamesScanReport at: 'isMetaRoot') ifFalse: [each classNamesScanReport at: 'CLASSNAME_usesAdifferentSuffixeThanRoot'] ]) asSet.
self allHierarchies do: [  :each|
	each at: 'CLASSNAME_usesAdifferentSuffixeThanRoot' put: ''.
	each at: 'CLASSNAME_isFalsePositive' put: ''. 
	each at: 'CLASSNAME_isNamedInconsistently' put: ''.
	each at: 'CLASSNAME_noteOnCoherence' put: 'Root'.
	each at: 'CLASSNAME_canBeFixedConformingToUnicityHypothesis' put: '' ].

self generateCSVFor: 'reports/Roassal'
]

{ #category : #'as yet unclassified' }
HierarchyScanReportFillingExample >> example3 [ 
"Where self is a FAMIXPackagesGroupScanner"
self allHierarchies
		do: [ :aHierarchy | 
			aHierarchy classesGroupedBySuffixes
				do: [ :suffixAndClasses | 
					suffixAndClasses
						do: [ :each | 
							
							(each at: 'classSuffix') = (aHierarchy at: 'classSuffix') "Coherent Hierarchies and classes with same suffix as Root"
								ifTrue: [ each at: 'CLASSNAME_usesSameSuffixeAsRoot' put: 'YES'.
									each at: 'CLASSNAME_isFalsePositive' put: ''.
									each at: 'CLASSNAME_isNamedConsistently' put: 'YES'.
									each at: 'CLASSNAME_noteOnCoherence' put: ''.
									each at: 'CLASSNAME_canBeFixedConformingToUnicityHypothesis' put: '' ]
								ifFalse: [ "PLEASE Inspect self allIncoherentHierarchies and edit one by one" ] ] ].
	aHierarchy at: 'CLASSNAME_usesSameSuffixeAsRoot' put: ''.
	aHierarchy at: 'CLASSNAME_isNamedConsistently' put: ''.	
		aHierarchy at: 'CLASSNAME_noteOnCoherence' put: 'Root'
						].
	self allIncoherentHierarchies 				
				
			self generateCSVFor: 'Reports/Calypso'

]
