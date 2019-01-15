Extension { #name : #FamixStClass }

{ #category : #'*classNamesAnalyzer' }
FamixStClass >> isMetaRoot [
	^self nameSuffix = 'Object'
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> isaRootClass [
	^self superclass = nil or: [self superclass isMetaRoot].
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> rootClass [
	^self superclasses first.
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> scanClassNames [
	^FAMIXClassScanner scan: self
]
