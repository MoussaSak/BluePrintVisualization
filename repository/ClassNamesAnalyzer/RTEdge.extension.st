Extension { #name : #RTEdge }

{ #category : #'*classNamesAnalyzer' }
RTEdge >> colorEdgesFromSubClassesIn: aColor whenEntring: entring [
	self color: aColor.
	"self from trachelShape color: (entring ifFalse:[self to trachelShape color adjustBrightness: -0.25] ifTrue:[self to trachelShape color adjustBrightness: 0.25])."
	self from trachelShape rectangle: (self to trachelShape rectangle expandBy:(entring ifTrue:[-0.2] ifFalse: [0.03])).
	self from shape borderColor: (entring ifTrue: [Color green] ifFalse: [Color black]).

	self from trachelShape signalUpdate.
	self to shape updateFor: self to trachelShape: self to trachelShape.

]

{ #category : #'*ClassNamesAnalyzer' }
RTEdge >> colorEdgesToSubClassesIn: aColor [ 
	self color: aColor.
	self from incomingEdges do: [:each| each colorEdgesToSubClassesIn: aColor] 
]

{ #category : #'*ClassNamesAnalyzer' }
RTEdge >> colorEdgesToSuperClassesIn: aColor [ 
	self color: aColor.
	self to outgoingEdges do: [:each| each colorEdgesToSuperClassesIn: aColor] 
]

{ #category : #'*classNamesAnalyzer' }
RTEdge >> colorEdgesToSuperClassesIn: aColor whenEntring: entring [
	self color: aColor.
	"self to trachelShape color: (entring ifFalse:[self to trachelShape color adjustBrightness: 0.25] ifTrue:[self to trachelShape color adjustBrightness: -0.25]).
	self to trachelShape rectangle: (self to trachelShape rectangle expandBy:(entring ifTrue:[0.2] ifFalse: [-0.2]))."
	self to shape borderColor: (entring ifTrue: [Color red] ifFalse: [Color black]).
	self to shape scale: (entring ifTrue:[1.2] ifFalse: [0.83]).
	
	self to trachelShape signalUpdate.
	self to shape updateFor: self to trachelShape: self to trachelShape.
	
	self to outgoingEdges do: [:each| each colorEdgesToSuperClassesIn: aColor whenEntring: entring] 
]
