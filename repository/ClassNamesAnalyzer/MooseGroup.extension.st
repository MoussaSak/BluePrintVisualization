Extension { #name : #MooseGroup }

{ #category : #'*ClassNamesAnalyzer' }
MooseGroup >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ self vocabularyScanner classBluePrint ]
]

{ #category : #'*ClassNamesAnalyzer' }
MooseGroup >> scanClassNames [
	^FAMIXPackagesGroupScanner scan: self.
]

{ #category : #'*ClassNamesAnalyzer' }
MooseGroup >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: (FAMIXPackagesGroupScanner scan: self)) value ].
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
MooseGroup >> vocabularyScanner: aFAMIXPackagesGroupScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXPackagesGroupScanner
]
