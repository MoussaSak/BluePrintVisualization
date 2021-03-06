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
FAMIXClass >> indexOfTheClassInHierarchy [
	^self classNamesScanReport indexOfTheClassInHierarchy.
]

{ #category : #'*classNamesAnalyzer' }
FAMIXClass >> indexOfTheClassInSubHierarchy [
	^self vocabularyScanner classNamesScanReport indexOfTheClassInSubHierarchy.
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
FAMIXClass >> nameAnalyser [
	^FAMIXClassAnalyser scan: self
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> nameSuffix [
	^self name suffixWithCamelCase.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> rootClass [
	^self superclasses first.
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> superclasses [
	 ^ self isaRootClass
		ifTrue: [ OrderedCollection with: self ]
		ifFalse: [ self superclass superclasses
				add: self;
				yourself ]
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> vocabularyScanner [
	| a |
	a := self privateState
		attributeAt: #vocabularyScanner
		ifAbsentPut: [ nil ].
	a
		ifNil: [ a := (self privateState
				attributeAt: #vocabularyScanner
				put: self nameAnalyser) value ].
	^ a
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClass >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
