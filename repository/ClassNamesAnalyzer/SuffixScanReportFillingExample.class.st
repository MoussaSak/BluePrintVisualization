"
this class/method is not executable.
it is just inteded to give guidelines on how to update a SuffixScanReport with manual analysis information
"
Class {
	#name : #SuffixScanReportFillingExample,
	#superclass : #Object,
	#category : #'ClassNamesAnalyzer-Examples'
}

{ #category : #'as yet unclassified' }
SuffixScanReportFillingExample >> example1 [
"this class/method is not executable.
it is just inteded to give guidelines on how to update a SuffixScanReport with manua analysis information"
| aGroupOfPackagesScanReport associations |
associations := aGroupOfPackagesScanReport allInCoherentSuffixes
associations do: [:each | each value 
	at: 'suffix:' put: self value suffix;
	at: 'isUsedInManyHierarchies' put: 'YES'; "put yes if the suffix is used in more than one hierarchy"
	at: 'isFalsePositive' put: 'NO'; "put the name of the categorie of the false positive that violates the concept unicity assumption : synonyms, GeneralTermSuffix, suffixDropping, SameSuffixDifferentRepresentations, ... The false positive means that the suffix is not ambiguous despite it violates the concept unicity assumption
	Put NO otherwise "
	at: 'isTrueAmbiguous' put: 'YES'; "put YES if the suffix is used improperly and some classes should be renamed"
	at: 'note' put: 'Why RTAction different from GLMRoassal2Action?'; "Explain why you consider the suffix is ambiguous/falsepositive"
	at: 'canBeFixedConformingToUnicityHypothesis' put: 'Unknown' "Put YES if you beleive that some classes could be renamed conforming to unicity hypothesis"
	].
]
