Extension { #name : #FAMIXClass }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> allSubInheritances [
	|aCollection|
	aCollection := OrderedCollection new.
	aCollection addAll: subInheritances.
	^aCollection addAll: ((subInheritances collect: #from) flatCollect: #allSubInheritances);yourself
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> classNamesScanReport [
	^self vocabularyScanner classNamesScanReport.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> indiceOfTheClassInHierarchy [
	^self classNamesScanReport indiceOfTheClassInHierarchy.
]

{ #category : #'*classNamesAnalyzer' }
FAMIXClass >> indiceOfTheClassInSubHierarchy [
	^self vocabularyScanner classNamesScanReport indiceOfTheClassInSubHierarchy.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> isMetaRoot [
	^self nameSuffix = 'Object'
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> isaRootClass [
	^self superclass = nil or: [self superclass isMetaRoot].
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

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> vocabularyScanner [
|a|
a := 
	self privateState attributeAt: #vocabularyScanner ifAbsentPut: (nil).
	a ifNil: [ a := (self privateState attributeAt: #vocabularyScanner put: ( self scanClassNames )) value ].
	^a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
