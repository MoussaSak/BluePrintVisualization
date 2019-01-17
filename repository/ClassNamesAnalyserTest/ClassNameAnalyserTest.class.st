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

	self assert: model allModelPackages first class equals: FAMIXPackage.
	self
		assert: model allModelPackages first vocabularyScanner class
		equals: FAMIXPackageAnalyser.
	"we should have a model in the future with more than one package so that we can test the FAMIXPackageGroupAnalyser"
	self
		assert: model allModelPackages first vocabularyScanner scannedEntities
		equals: model allModelPackages first
]
