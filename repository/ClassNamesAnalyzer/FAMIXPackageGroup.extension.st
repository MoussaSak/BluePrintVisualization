Extension { #name : #FAMIXPackageGroup }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> packageViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	<moosePresentationOrder: -20>
	composite roassal2
		title: 'NameBlueprint';
		initializeView: [ self vocabularyScanner classBluePrint ]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> scanClassNames [
	^FAMIXPackagesGroupScanner scan: self.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner [
	^ vocabularyScanner ifNil:[vocabularyScanner := FAMIXPackagesGroupScanner scan: self]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner: aFAMIXPackagesGroupScanner [ 
	vocabularyScanner := aFAMIXPackagesGroupScanner 

]
