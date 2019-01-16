Extension { #name : #FAMIXPackage }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> addClassBlueprintLegendOn: view [
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
FAMIXPackage >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: '42NameBlueprint';
		initializeView: [ | view |
			view := self vocabularyScanner classBluePrint.
			self addClassBlueprintLegendOn: view view.
			view ]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> scanClassNames [
	^FAMIXPackageScanner scan: self
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> viewInClassBluePrint [
	^'package Name: ', (self vocabularyScanner classNamesScanReport at: 'packageName') asString
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: (FAMIXPackageScanner scan: self)) value ].
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
