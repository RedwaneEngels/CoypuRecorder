Class {
	#name : #PerformanceTextualReplayer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'performanceScript'
	],
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #accessing }
PerformanceTextualReplayer >> displayInTranscript [

	performanceScript do: [ :each | each traceCr ]
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScript: aSavedPerformance [

	aSavedPerformance scriptForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithRelativeTime: aSavedPerformance [

	aSavedPerformance scriptWithRelativeTimeForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithTime: aSavedPerformance [

	aSavedPerformance scriptWithTimeForReplayer: self
]

{ #category : #accessing }
PerformanceTextualReplayer >> performanceScript: anOrderedCollection [

performanceScript := anOrderedCollection 
]

{ #category : #accessing }
PerformanceTextualReplayer >> replay [

	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"
	
'.
	content := content , String cr.
	content := content , ('' join: (performanceScript collect:[:each| each,String cr])).
	^ StPlayground openContents: content
]

{ #category : #accessing }
PerformanceTextualReplayer >> writeScriptInStonFile [

	| x script stream |
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [
		(x / DateAndTime now asDate asString) ensureCreateDirectory ].

	script := (x / 'Performance' , 'ston') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: 'Performance' extension: 'ston') ].
	script := script asFileReference.
	stream := script writeStream.

	STON put: (performanceScript collect:[:each | each, String cr]) asArray asJsonOnStreamPretty: stream.
	stream close
]

{ #category : #accessing }
PerformanceTextualReplayer >> writeScriptInTxtFile [

	| x script stream counter |
	counter := ''.
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [
		(x / DateAndTime now asDate asString) ensureCreateDirectory ].

	script := (x / 'Performance' , 'txt') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: 'Performance' extension: 'txt') ].

	script := script asFileReference.
	stream := script writeStream.
	performanceScript do: [ :each |
		stream
			nextPutAll: each;
			nextPutAll: String cr ].
	stream close
]
