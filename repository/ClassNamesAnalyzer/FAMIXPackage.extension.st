Extension { #name : #FAMIXPackage }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackage >> scanClassNames [
	^FAMIXPackageScanner scan: self
]
