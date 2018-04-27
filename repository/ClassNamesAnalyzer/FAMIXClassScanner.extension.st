Extension { #name : #FAMIXClassScanner }

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClassScanner >> defaultMetrics [
	"use 'aFAMIXClassScanner classNamesScanReport' whenever an expensive computation is required and has been computed in a previous metric
	Example : rootClass uses the metric superclasses"
	
		^ Dictionary new
		at: 'scannedClasses' put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass  ];
		at: 'className' put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass name ];
		at: 'classSuffix' put: [ :aFAMIXClassScanner | aFAMIXClassScanner scannedClass name splitWithCamelCase last];
		at: 'superclasses' put: [  :aFAMIXClassScanner | aFAMIXClassScanner scannedClass superclasses ];
		at: 'rootClass' put: [  :aFAMIXClassScanner | (aFAMIXClassScanner classNamesScanReport at: 'superclasses') first];
		yourself
]

{ #category : #'*ClassNamesAnalyzer' }
FAMIXClassScanner class >> reportClass [
	^ClassScanReport
]
