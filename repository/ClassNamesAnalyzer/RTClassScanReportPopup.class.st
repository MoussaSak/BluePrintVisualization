Class {
	#name : #RTClassScanReportPopup,
	#superclass : #RTPopup,
	#category : #'ClassNamesAnalyzer-Visualization'
}

{ #category : #'as yet unclassified' }
RTClassScanReportPopup >> initializeElement: element [
	super initializeElement: element.
	element
		when: TRMouseEnter
		do: [ :event | 
			element outgoingEdges
				do: [ :each | each color: (Color black alpha: 1) ] .
			element incomingEdges 
				do: [ :each | each color: Color red ]].
	element
		when: TRMouseLeave
		do: [ :event | 
			(element outgoingEdges union: element incomingEdges)
				do: [ :each | each color: ((each from color adjustBrightness: -0.1) alpha: 0.1) ].
			element trachelShape signalUpdate ]
	"element
		when: TRMouseDragging
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ]"
]
