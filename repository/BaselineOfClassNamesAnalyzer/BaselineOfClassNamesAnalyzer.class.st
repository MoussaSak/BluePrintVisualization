Class {
	#name : #BaselineOfClassNamesAnalyzer,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNamesAnalyzer
}

{ #category : #baselines }
BaselineOfClassNamesAnalyzer >> baseline: spec [
  <baseline>
  spec
    for: #common
    do: [
		"Packages"
      spec
        package: 'ClassNamesAnalyzer' with: [spec requires: #('ColorsExtensions' 'Moose')];
        package: 'ClassNamesAnalyzer-Examples' with: [spec requires: #('ClassNamesAnalyzer')];
        package: 'ClassNamesAnalyzer-Reports' with: [spec requires: #('ClassNamesAnalyzer')];
        package: 'ClassNamesAnalyzer-Tests' with: [spec requires: #('ClassNamesAnalyzer')];
        package: 'ClassNamesAnalyzer-Visualization' with: [spec requires: #('ClassNamesAnalyzer' 'ColorsExtensions' 'Moose')].
  		spec
    	baseline: 'ColorsExtensions'
    	with: [ spec repository: 'github://pharo-contributions/ColorsExtensions:master/src' ] .
		spec
      baseline: 'Moose'
      with: [ spec repository: 'github://moosetechnology/Moose:development/src' ].	
     ]
]
