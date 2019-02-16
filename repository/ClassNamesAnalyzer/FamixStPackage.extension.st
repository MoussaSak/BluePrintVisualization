Extension { #name : #FamixStPackage }

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> addClassBlueprintLegendOn: view [
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

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> nameAnalyser [
	^FAMIXPackageAnalyser scan: self
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'PNameBlueprint';
		initializeView: [ | view |
			view := self vocabularyScanner classBluePrint.
			self addClassBlueprintLegendOn: view view.
			view ]
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> viewInClassBluePrint [
	^ 'package Name: ', (self vocabularyScanner classNamesScanReport at: 'packageName') asString
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> vocabularyScanner [
	| a |
	a := self privateState
		attributeAt: #vocabularyScanner
		ifAbsentPut: [ nil] .
	a
		ifNil: [ a := (self privateState
				attributeAt: #vocabularyScanner
				put: (FAMIXPackageAnalyser scan: self)) value ].
	^ a
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStPackage >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
