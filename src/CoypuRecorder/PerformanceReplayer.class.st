Class {
	#name : #PerformanceReplayer,
	#superclass : #Object,
	#instVars : [
		'performanceScript'
	],
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #accessing }
PerformanceReplayer >> displayInTranscript [

	performanceScript do: [ :each | each traceCr ]
]

{ #category : #visiting }
PerformanceReplayer >> getScript: aSavedPerformance [

	^ self subclassResponsibility
]

{ #category : #accessing }
PerformanceReplayer >> performanceScript [

^	performanceScript 
]

{ #category : #accessing }
PerformanceReplayer >> performanceScript: anOrderedCollection [

	performanceScript := anOrderedCollection
]

{ #category : #'read/write usage' }
PerformanceReplayer >> readScriptFromStonFile: aPathToAFile [

	| stream |
	stream := aPathToAFile asFileReference readStream.
	self performanceScript: (STON fromStream: stream)
]

{ #category : #accessing }
PerformanceReplayer >> replay [

	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"'.
	content := content , String cr.
	content := content , ('' join: performanceScript).
	^ StPlayground openContents: content
]

{ #category : #'read/write usage' }
PerformanceReplayer >> writeScriptInStonFile [
	^ self subclassResponsibility
]

{ #category : #'read/write usage' }
PerformanceReplayer >> writeScriptInStonFile: aNameFile [

	| x script stream |
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [ x ensureCreateDirectory ].

	script := (x / aNameFile , 'ston') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: aNameFile extension: 'ston') ].
	script := script asFileReference.
	stream := script writeStream.

	STON put: performanceScript asArray asJsonOnStreamPretty: stream.
	stream close
]

{ #category : #'read/write usage' }
PerformanceReplayer >> writeScriptInTxtFile: aNameFile [

	| x script stream |
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [ x ensureCreateDirectory ].

	script := (x / 'TextualPerformance' , 'txt') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: aNameFile extension: 'txt') ].

	script := script asFileReference.
	stream := script writeStream.
	performanceScript do: [ :each |
		stream
			nextPutAll: each;
			nextPutAll: String cr ].
	stream close
]
