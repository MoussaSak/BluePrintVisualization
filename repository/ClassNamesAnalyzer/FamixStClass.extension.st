Extension { #name : #FamixStClass }

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> allSubInheritances [
	|aCollection|
	aCollection := OrderedCollection new.
	aCollection addAll: subInheritances.
	^aCollection addAll: ((subInheritances collect: #from) flatCollect: #allSubInheritances);yourself
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> classNamesScanReport [
	^self vocabularyScanner classNamesScanReport.
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> indexOfTheClassInHierarchy [
	^self classNamesScanReport indexOfTheClassInHierarchy.
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> indexOfTheClassInSubHierarchy [
	^self vocabularyScanner classNamesScanReport indexOfTheClassInSubHierarchy.
]

{ #category : #'*classNamesAnalyzer' }
FamixStClass >> isMetaRoot [
	^self nameSuffix = 'Object'
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> isaRootClass [
	^self superclass = nil or: [self superclass isMetaRoot].
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> nameAnalyser [
	^FAMIXClassAnalyser scan: self
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> nameSuffix [
	^self name suffixWithCamelCase.
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> rootClass [
	^self superclasses first.
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> superclasses [
	 ^ self isaRootClass
		ifTrue: [ OrderedCollection with: self ]
		ifFalse: [ self superclass superclasses
				add: self;
				yourself ]
]

{ #category : #'*ClassNamesAnalyzer' }
FamixStClass >> vocabularyScanner [
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
FamixStClass >> vocabularyScanner: aFAMIXClassScanner [ 
	self privateState attributeAt: #vocabularyScanner put: aFAMIXClassScanner.
]
