Extension { #name : #Association }

{ #category : #'*classNamesAnalyzer' }
Association >> mouseAnnouncer [
	^RTPopup new text: self viewInClassBluePrint
]

{ #category : #'*classNamesAnalyzer' }
Association >> viewInClassBluePrint [
	^value
]
