Class {
	#name : #ClassScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #Visualisation }
ClassScanReport >> mouseAnnouncer [
	^RTClassScanReportPopup new text: self viewInClassBluePrint; alphaPopupBackground: 0.7; textColor: Color green; backgroundColor: Color black
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
