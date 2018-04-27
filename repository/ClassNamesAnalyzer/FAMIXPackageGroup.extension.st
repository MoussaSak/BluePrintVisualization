Extension { #name : #FAMIXPackageGroup }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXPackageGroup >> scanClassNames [
	^FAMIXPackagesGroupScanner scan: self.
]
