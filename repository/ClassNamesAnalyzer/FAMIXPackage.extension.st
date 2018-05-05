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
	^'package Name: ', (vocabularyScanner classNamesScanReport at: 'packageName') asString
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> vocabularyScanner [
	^ vocabularyScanner ifNil:[vocabularyScanner := FAMIXPackageScanner scan: self]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> vocabularyScanner: aFAMIXPackageScanner [ 
	vocabularyScanner := aFAMIXPackageScanner 

]
