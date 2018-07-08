Extension { #name : #RTMondrian }

{ #category : #'*ClassNamesAnalyzer' }
RTMondrian >> edges: objects fromElement: fromBlock toElement: toBlock [ 
	^ self edges 
			elements: objects;
			connectFromElement: fromBlock toElement: toBlock
		
]
