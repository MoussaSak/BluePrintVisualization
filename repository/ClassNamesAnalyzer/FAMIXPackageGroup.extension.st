Extension { #name : #FAMIXPackageGroup }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> addClassBlueprintLegendOn: view [
	| lb |
	lb := RTLegendBuilder new.
	"lb onDemand."
	self flag: #toFix. "This duplicated code it means that an entity is missing to which we should dispatch."
	lb view: view.
	lb addColor: Color white text: 'Single class hierarchy'.
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
FAMIXPackageGroup >> nameAnalyser [
	^FAMIXPackagesGroupAnalyser scan: self.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'PGNameBlueprint';
		initializeView: [ | view |
		
			view := self vocabularyScanner classBluePrint.
			self addClassBlueprintLegendOn: view view.
			view ]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner [
	| a |
	a := self privateState
		attributeAt: #vocabularyScanner
		ifAbsentPut: [nil].
	a
		ifNil: [ a := (self privateState
				attributeAt: #vocabularyScanner
				put: (FAMIXPackagesGroupAnalyser scan: self)) value ].
	^ a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner: aFAMIXPackagesGroupScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXPackagesGroupScanner
]
