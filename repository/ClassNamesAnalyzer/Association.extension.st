Extension { #name : #Association }

{ #category : #'*ClassNamesAnalyzer' }
Association >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*ClassNamesAnalyzer' }
Association >> viewInClassBluePrint [
	^value
]
