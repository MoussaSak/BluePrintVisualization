Extension { #name : #String }

{ #category : #'*ClassNamesAnalyzer' }
String >> splitWithCamelCase [
"
'GoodMoriningAmerica' splitWithCamelCase = (OrderedCollection with:'Good' with:'Morining' with:'America')"
"'GCOptimizer' splitWithCamelCase = (OrderedCollection with:'GC' with:'Optimizer')"
"'optimizerOfGC' splitWithCamelCase  = (OrderedCollection with:'optimizer' with: 'Of' with: 'GC')
"

	| pastIndex  tokens newWord |
	self flag:' must consider the case of multiple uppercase letters :FMGenerator'.
	tokens := OrderedCollection new.
	newWord := false.
	pastIndex := 1.
	2 to: self size do: [ :index | 
		((((self at: index) asciiValue) > 64 and: [ ((self at: index) asciiValue) < 91 ]) and:[newWord])
			ifTrue: [ tokens add: (self collect: [ :each | each ] from: pastIndex to: index-1).
				pastIndex := index.newWord := false]ifFalse:[newWord := true]] .
		tokens add:(self collect:[:each | each ] from: pastIndex to: self size).
		^tokens

]

{ #category : #'*ClassNamesAnalyzer' }
String >> suffixWithCamelCase [
	"'CamelCase' suffixWithCamelCase =  'Case'."

	"'GoodMoriningAmerica' suffixWithCamelCase =  'America'."

	"'GCOptimizer' suffixWithCamelCase =  'Optimizer'."

	"'optimizerOfGC' suffixWithCamelCase = 'GC'."

	"'BrowserForFAMIX' remmoveAll: suffixWithCamelCase = 'FAMIX'"

	| indexOfCaseChange stringWithoutNumbers | 
	
	stringWithoutNumbers := self select: #isLetter.
	indexOfCaseChange := stringWithoutNumbers reverse first isLowercase
		ifTrue: [ stringWithoutNumbers reverse indexOf: (stringWithoutNumbers select: #isUppercase) last ]
		ifFalse: [ (stringWithoutNumbers reverse indexOf: (stringWithoutNumbers select: #isLowercase) last) - 1 ].
	^ stringWithoutNumbers copyFrom: stringWithoutNumbers size + 1 - indexOfCaseChange to: stringWithoutNumbers size
]
