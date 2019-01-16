"
I'm a little script to create a model without all the unnecessary information. 
We just need to have class, package and inheritance. 

	RunnableExamples loadInMooseHierarchyOf: ComposablePresenter
"
Class {
	#name : #RunnableExamples,
	#superclass : #Object,
	#category : #'ClassNamesAnalyzer-Tests'
}

{ #category : #loading }
RunnableExamples class >> loadInMooseHierarchyOf: aClass [
	| packages model importer hierarchyToAnalyze |
	hierarchyToAnalyze := aClass.
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
	packages := hierarchyToAnalyze allSubclasses
		collect: [ :each | each package name ]
		as: Set.
	packages do: [ :each | importer addFromPackageNamed: each ].
	importer run.
	model name: hierarchyToAnalyze name.
	^ model install
]
