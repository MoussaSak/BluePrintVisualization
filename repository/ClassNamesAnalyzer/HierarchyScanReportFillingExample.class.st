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
