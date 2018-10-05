Extension { #name : #FAMIXScopingEntity }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ self vocabularyScanner classBluePrint]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> scanClassNames [
	^FAMIXPackageScanner scan: self
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> viewInClassBluePrint [
	^'package Name: ', (self vocabularyScanner classNamesScanReport at: 'packageName') asString
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: (FAMIXPackageScanner scan: self)) value ].
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXScopingEntity >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
