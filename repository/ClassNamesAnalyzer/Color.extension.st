Extension { #name : #Color }

{ #category : #'*ClassNamesAnalyzer' }
Color >> adjustGray: anInteger [ 
	self = Color gray ifTrue: [ ^self alphaMixed: 1/anInteger with: Color white ] "return self elsewhwere"
	.

]
