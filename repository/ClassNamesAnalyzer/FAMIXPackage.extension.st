Extension { #name : #FAMIXPackage }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ self vocabularyScanner classBluePrint]
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
