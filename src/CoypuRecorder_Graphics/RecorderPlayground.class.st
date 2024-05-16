Class {
	#name : #RecorderPlayground,
	#superclass : #Object,
	#instVars : [
		'codeEditor',
		'toolBar',
		'playground',
		'replayer'
	],
	#category : #'CoypuRecorder_Graphics'
}

{ #category : #'as yet unclassified' }
RecorderPlayground >> button: aName icon: aPathToAnIcon event: aMessage [

	| button |
	button := ToButton new.
	button label: (ToLabel text: aName).
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: aPathToAnIcon)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self load ].
	^ button
]

{ #category : #'as yet unclassified' }
RecorderPlayground >> codeEditorInitialize [

	| album menuBuilder |
	album := ToAlbum new.
	album styler: (BlRBTextStyler new classOrMetaClass: self class).
	album withSaveCapability.
	album withRowNumbers.
	album whenSaveRequestedDo: [ :saveRequested |
		saveRequested accepted: true ].
	album whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: '' ].

	menuBuilder := [ :menu :request |
	               | element |
	               element := request currentTarget.
	               menu addItem: (ToMenuItem new
			                labelText: 'Select all';
			                whenClickedDo: [ :event |
				                element selecter
					                all;
					                apply ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Copy';
			                whenClickedDo: [ :event |
				                element editor copySelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Cut';
			                whenClickedDo: [ :event |
				                element editor cutSelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Paste';
			                whenClickedDo: [ :event | element editor paste ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Accept';
			                whenClickedDo: [ :event | element requestSave ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Cancel';
			                whenClickedDo: [ :event | element requestCancel ];
			                yourself) ].
	album contextMenu: menuBuilder.
	album cursorColor: Color cyan.

	^ album
]

{ #category : #'command line' }
RecorderPlayground >> hello [
]

{ #category : #initialization }
RecorderPlayground >> initialize [

	super initialize.
	replayer := PerformanceMusicalReplayer.
	self playgroundInitialize.
	replayer := PerformanceMusicalReplayer new.
	codeEditor := self codeEditorInitialize.
	toolBar := self toolBarInitialize.
	playground addChild: toolBar.
	playground addChild: codeEditor.
	playground openInSpace
]

{ #category : #actions }
RecorderPlayground >> load [

	| x |
	'hello' traceCr.
	x := UIManager default
		     chooseExistingFileReference: 'Select the ston file'
		     extensions: #( 'ston' )
		     path: FileLocator home.
	replayer readScriptFromStonFile: x.
	codeEditor text: ''.
	replayer performanceScript do: [ :each |
		codeEditor text: codeEditor text asString , each ]
]

{ #category : #playing }
RecorderPlayground >> play [
'hello play' traceCr.
	replayer performanceScript:
		(codeEditor text asString substrings: String cr).

	replayer replayWithoutPlayground
]

{ #category : #'as yet unclassified' }
RecorderPlayground >> playgroundInitialize [

	playground := ToPane new
		              id: #listPane;
		              margin: (BlInsets top: 0 bottom: 5).
	playground layout: (BlLinearLayout vertical cellSpacing: 0).
	playground matchParent
]

{ #category : #actions }
RecorderPlayground >> save [

	replayer performanceScript:
		(codeEditor text asString substrings: String cr).
		
	replayer writeScriptInStonFile
]

{ #category : #accessing }
RecorderPlayground >> stop [

	'hello stop' traceCr.
	Performance uniqueInstance stop
]

{ #category : #'as yet unclassified' }
RecorderPlayground >> toolBarInitialize [

	| bar button |
	bar := ToElement new.
	bar geometry: BlRectangleGeometry new.
	bar size: 350 @ 30.
	bar layout: (BlLinearLayout horizontal cellSpacing: 0).
	"bar
		addChild: (self button: 'Play' icon: #glamorousGo event: self play);
		addChild: (self button: 'Stop' icon: #stop event: self stop);
		addChild: (self button: 'Load' icon: #open event: self load);
		addChild:
			(self button: 'Save' icon: #glamorousSave event: self hello)."
	button := ToButton new.
	button label: (ToLabel text: 'Play').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #glamorousGo)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self play ].
	bar addChild: button.
	button := ToButton new.
	button label: (ToLabel text: 'Stop').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #stop)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self stop ].
	bar addChild: button.
	button := ToButton new.
	button label: (ToLabel text: 'Load').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #open)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self load ].
	bar addChild: button.
		button := ToButton new.
	button label: (ToLabel text: 'Save').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #glamorousSave)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self hello ].
	bar addChild: button.
	^ bar
]
