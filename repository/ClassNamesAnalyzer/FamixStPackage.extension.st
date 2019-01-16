Extension { #name : #FamixStPackage }

{ #category : #'*classNamesAnalyzer' }
FamixStPackage >> indexOfTheClassInSubHierarchy [
	^self vocabularyScanner classNamesScanReport indexOfTheClassInSubHierarchy.
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
