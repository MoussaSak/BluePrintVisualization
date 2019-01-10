Class {
	#name : #BaseLineOfClassNamesAnalyzer,
	#superclass : #BaselineOf,
	#category : #BaseLineOfClassNamesAnalyzer
}

{ #category : #baselines }
BaseLineOfClassNamesAnalyzer >> baseline: spec [
  <baseline>
  spec
    for: #common
	 
    do: [
	"Dependencies"
	self classNamesAnalyzer: spec.
	"Packages"
      spec
        package: 'ClassNamesAnalyzer';
        package: 'ClassNamesAnalyzer-Examples' with: [spec requires: #('ClassNamesAnalyzer')];
        package: 'ClassNamesAnalyzer-Reports';
        package: 'ClassNamesAnalyzer-Tests';
        package: 'ClassNamesAnalyzer-Extensions'.
  		spec
    	baseline: 'ColorsExtensions'
    	with: [ spec repository: 'github://pharo-contributions/ColorsExtensions:master/src' ] .
		spec
      baseline: 'Moose'
      with: [ spec repository: 'github://moosetechnology/Moose:master/src' ].
		spec
    	for: #(#'pharo6.x' #'pharo7.x')
     ]
]
