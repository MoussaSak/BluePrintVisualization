Extension { #name : #FAMIXPackageGroup }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> addClassBlueprintLegendOn: view [
	| lb |
	lb := RTLegendBuilder new.
	"lb onDemand."
	lb view: view.
	lb addColor: Color white text: 'Sigle class hierarchy'.
	lb addColor: Color gray text: 'Single suffix hierarchy'.
	((self vocabularyScanner classNamesScanReport at: 'allRootClasses') asSet collect: #key)
		do: [ :each | 
			((self mooseModel dictionaryOfRootClassColors at: each) = Color white
				or: (self mooseModel dictionaryOfRootClassColors at: each) = Color gray)
				ifFalse: [ lb addColor: (self mooseModel dictionaryOfRootClassColors at: each) text: each name ] ].
	"lb addColor: Color blue text: 'TestAsserter hierarchy'"
	lb build
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ |view|
			view := self vocabularyScanner classBluePrint.
			self addClassBlueprintLegendOn: view view.
			view ]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> scanClassNames [
	^FAMIXPackagesGroupScanner scan: self.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: (FAMIXPackagesGroupScanner scan: self)) value ].
	
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner: aFAMIXPackagesGroupScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXPackagesGroupScanner
]
