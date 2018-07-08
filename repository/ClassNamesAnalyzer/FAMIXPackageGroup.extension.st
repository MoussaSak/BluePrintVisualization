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
	^self privateState attributeAt: #vocabularyScanner ifAbsentPut: (FAMIXPackagesGroupScanner scan: self)
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> vocabularyScanner: aFAMIXPackagesGroupScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXPackagesGroupScanner
]
