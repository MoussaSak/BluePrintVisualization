Class {
	#name : #ClassScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #'as yet unclassified' }
ClassScanReport >> classReportViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ self hierarchicalVisualisationWithCouleredSuffixes]

]

{ #category : #'as yet unclassified' }
ClassScanReport >> groupOfPackagesScanReport [
	"Ugly hack. Should be removed once suffixes are grouped in a dedicated report"
	^self scannedEntity mooseModel allPackages scanClassNames classNamesScanReport
]

{ #category : #'as yet unclassified' }
ClassScanReport >> hierarchicalVisualisationWithCouleredSuffixes [
	| b aDico |
	b := RTMondrian new.
aDico := Dictionary new.
b shape rectangle withTextAbove: [:each| each at: 'className'];
color: [ :aReport | 
					aDico at: (aReport at: 'classSuffix') ifAbsentPut: Color random].

b nodes: ((((((self at: 'rootClass') allSubInheritances collect: #from) addFirst: (self at: 'rootClass'); yourself) collect: #vocabularyScanner) collect: #classNamesScanReport) 
	
	
	sort: [:first :second| (first at:'classSuffix') = ((first at: 'superclasse') vocabularyScanner classNamesScanReport at: 'classSuffix')] ).

b layout tree"weightedCircle".
b edges connectFrom: [ :each|
	 (each at: 'superclasse') vocabularyScanner classNamesScanReport].


^b


]

{ #category : #Visualisation }
ClassScanReport >> mouseAnnouncer [
	^RTClassScanReportPopup new text: self viewInClassBluePrint; alphaPopupBackground: 0.7; textColor: Color green; backgroundColor: Color black
]

{ #category : #accessing }
ClassScanReport >> scannedClass [
	^self at: 'scannedClasses'.
]

{ #category : #Visualisation }
ClassScanReport >> viewInClassBluePrint [
	^'className: ',(self at: 'className'), String cr,
	 'superclass: ',(self at: 'superclasse') name, String cr,
	 'Root Class: ',(self at: 'rootClass') name. 
]
