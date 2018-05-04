Class {
	#name : #ClassScanReport,
	#superclass : #VocabularyScanReport,
	#category : #'ClassNamesAnalyzer-Reports'
}

{ #category : #accessing }
ClassScanReport >> rtValue: anArgument [ 
	^ self at: 'className'
]

{ #category : #accessing }
ClassScanReport >> scannedClass [
	^self at: 'scannedClasses'.
]

{ #category : #Visualizations }
ClassScanReport >> viewInClassBluePrint [
	^'className: ',(self at: 'className'), String cr,
	 'superclass: ',(self at: 'superclasse') name, String cr,
	 'Root Class: ',(self at: 'rootClass') name. 
]
