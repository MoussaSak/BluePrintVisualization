Class {
	#name : #ClassNameAnalyserTest,
	#superclass : #TestCase,
	#category : #ClassNamesAnalyserTest
}

{ #category : #tests }
ClassNameAnalyserTest >> testFirst [
	| model importer packages |
	model := MooseModel new.
	importer := MoosePharoImporterTask new model: model.
	importer factory: SmalltalkCompatibilityMetamodelFactory.
	importer
		importingContext:
			(MooseImportingContext new
				mergeClassAndMetaclass;
				importClass;
				importPackage;
				importInheritance;
				yourself).
	packages := #(ClassNamesAnalyzerResourcesForTest).
	packages do: [ :each | importer addFromPackageNamed: each ].
	importer run.
	model name: 'ClassNamesAnalyzerResourcesForTest'.
	model install.
	self halt. 
	"(model allModelPackages entityWithName: vocabularyScanner) nameAnalyser"
	
	
]
