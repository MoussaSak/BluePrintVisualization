Extension { #name : #RTEdgeBuilder }

{ #category : #'*ClassNamesAnalyzer' }
RTEdgeBuilder >> connectFromElement: aString toElement: aBlockClosure [ 
	"connectFrom: aFromBlock to: aBlockOrASymbol"
	| toElement fromElement |
	self resetCreatedEdges.
	self fromElements copy
		do: [ :e | 
			fromElement := e.
			toElement := aBlockClosure value: e model.
			toElement ifNotNil: [ self createEdgeIfNecessaryFrom: fromElement to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]
