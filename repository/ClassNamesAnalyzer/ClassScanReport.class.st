Class {
	#name : #ClassScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #Visualisation }
ClassScanReport >> mouseAnnouncer [
	^RTClassScanReportPopup new text: self viewInClassBluePrint
]

{ #category : #accessing }
ClassScanReport >> scannedClass [
	^self at: 'scannedClasses'.
]

{ #category : #Visualisation }
ClassScanReport >> viewInClassBluePrint [
	^'className: ',(self at: 'className'), String cr,
	 'superclass: ',(self at: 'superclasse') name, String cr,
	 'Root Class: ',(self at: 'rootClass') name. 
]

{ #category : #Visualisation }
ClassScanReport >> visualElement [
	^self scannedEntity visualElement.
]

{ #category : #Accessing }
ClassScanReport >> visualElement: aRTElement [ 
	self scannedEntity visualElement: aRTElement.
]
