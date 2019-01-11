Class {
	#name : #RTClassScanReportPopupWithoutSubclasses,
	#superclass : #RTPopup,
	#category : #'ClassNamesAnalyzer-Visualization'
}

{ #category : #'as yet unclassified' }
RTClassScanReportPopupWithoutSubclasses >> initializeElement: element [
	super initializeElement: element.
	element
		when: TRMouseEnter
		do: [ :event | 
			element outgoingEdges
				do: [ :each | 
					each colorEdgesToSuperClassesIn: Color red whenEntring: true.
					  ] .
			element incomingEdges 
				do: [ :each |
					each colorEdgesFromSubClassesIn: Color blue whenEntring: true ]
			].
	element
		when: TRMouseLeave
		do: [ :event | 
			element outgoingEdges
				do: [ :each | each colorEdgesToSuperClassesIn: ((each from color adjustBrightness: -0.01) alpha: 0.01) whenEntring: false ].
			element incomingEdges
				do: [ :each | each colorEdgesFromSubClassesIn: ((each from color adjustBrightness: -0.01) alpha: 0.01) whenEntring: false ].
			element trachelShape signalUpdate ]
]
