Extension { #name : #FamixStPackage }

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> indiceOfTheClassInSubHierarchy [
	^self vocabularyScanner classNamesScanReport indiceOfTheClassInSubHierarchy.
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ |view|
			view := self vocabularyScanner classBluePrint.
			self addClassBlueprintLegendOn: view view.
			view ]
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> scanClassNames [
	^FAMIXPackageScanner scan: self
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> viewInClassBluePrint [
	^'package Name: ', (self vocabularyScanner classNamesScanReport at: 'packageName') asString
]

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: (FAMIXPackageScanner scan: self)) value ].
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStPackage >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
