Extension { #name : #FAMIXClass }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> isaRootClass [
	^self superclass = nil or: [self superclass nameSuffix = 'Object'].
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> nameSuffix [
	^self name splitWithCamelCase last.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> rootClass [
	^self superclasses first.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> scanClassNames [
	^FAMIXClassScanner scan: self
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> superclasses [
	self isaRootClass 
		ifTrue:[ ^ OrderedCollection with: self ]
		ifFalse: [ ^self superclass superclasses add: self;yourself ]
]
