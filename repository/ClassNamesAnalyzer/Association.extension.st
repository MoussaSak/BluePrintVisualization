Extension { #name : #Association }

{ #category : #'*ClassNamesAnalyzer' }
Association >> mouseAnnouncer [

	^RTPopup new text: self value viewInClassBluePrint; alphaPopupBackground: 0.7; textColor: Color green; backgroundColor: Color black
]

{ #category : #'*ClassNamesAnalyzer' }
Association >> viewInClassBluePrint [
	^value
]
