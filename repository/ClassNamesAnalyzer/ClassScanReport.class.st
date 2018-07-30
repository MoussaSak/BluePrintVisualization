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
	| b allHierarchyClasses allPackages aDico |
	aDico := Dictionary new.
allHierarchyClasses := ((((self at: 'rootClass') allSubInheritances collect: #from) addFirst: (self at: 'rootClass'); yourself) collect: #vocabularyScanner) collect: #classNamesScanReport.	
allPackages := (allHierarchyClasses collect: [ :each | each at: 'package' ]) asSet.

b := RTMondrian new.
b shape rectangle withTextAbove: [:each| each name];
color: Color transparent;
borderColor: Color gray.
b nodes: allPackages forEach: [ 
	:aPackage |
	b shape rectangle "withTextAbove: [:aReport | '']";
	size: 40;
	color: [ :aReport | 
					aDico at: (aReport at: 'classSuffix') ifAbsentPut: Color random].

	b nodes: (allHierarchyClasses select: [ :aReport | (aReport at: 'package') = aPackage ] ).
	b layout tree.
	b view elements do:[:element| element @ (RTMouseHoverZoom new desiredExtent: [ :anElement | anElement extent * 1.7 ])].
	b edges connectFrom: [ :each|
	 (each at: 'superclasse') vocabularyScanner classNamesScanReport]
	].
b view elements do: [:element| element removeConnectedEdges].

	b view elements do: [ :element| element announcer subscriptions  subscriptions do: [ :each | element announcer subscriptions  subscriptions remove: each ]].
	b view elements do: [ :element| element @ (element model mouseAnnouncer)].
b layout tree.

b shape line color: (Color gray).
b edges: allHierarchyClasses from: #yourself to: [ :aClassScanReport| (aClassScanReport at: 'superclasse') ifNotNil: [ (aClassScanReport at: 'superclasse') vocabularyScanner classNamesScanReport ] ].
b shape line color: (Color transparent).
b edges connectFromAll: [ :aPackage| 
	 aPackage queryOutgoingInheritances atPackageScope withoutSelfLoops asSet
	 ].



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
