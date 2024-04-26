Class {
	#name : #PerformanceTextualDisplayer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'performanceScript'
	],
	#category : #'CoypuRecorder-Displayer'
}

{ #category : #accessing }
PerformanceTextualDisplayer >> displayInTranscript [

	'p := PerformanceRecorder uniqueInstance .' traceCr.
	'p performer: PerformerSuperDirt new.' traceCr.
	'' traceCr.
	performanceScript do: [ :each |
		each traceCr ]
]

{ #category : #visiting }
PerformanceTextualDisplayer >> getScript: aSavedPerformance [

	aSavedPerformance scriptForDisplayer: self
]

{ #category : #visiting }
PerformanceTextualDisplayer >> getScriptWithRelativeTime: aSavedPerformance [

	aSavedPerformance scriptWithRelativeTimeForDisplayer: self
]

{ #category : #visiting }
PerformanceTextualDisplayer >> getScriptWithTime: aSavedPerformance [

	aSavedPerformance scriptWithTimeForDisplayer: self
]

{ #category : #accessing }
PerformanceTextualDisplayer >> performanceScript: anOrderedCollection [

performanceScript := anOrderedCollection 
]

{ #category : #accessing }
PerformanceTextualDisplayer >> writeScriptInStonFile [

	| x script stream counter |
	counter := ''.
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

	STON
		put: {
				{ 'p := PerformanceRecorder uniqueInstance.' } asArray.
				{ 'p performer: PerformerSuperDirt new.' } asArray .
				performanceScript asArray. } asJsonOnStreamPretty: stream.
	stream close

]

{ #category : #accessing }
PerformanceTextualDisplayer >> writeScriptInTxtFile [

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
	stream nextPutAll: 'p := PerformanceRecorder uniqueInstance.'.
	stream
		nextPutAll: String cr;
		nextPutAll: String cr;
		nextPutAll: 'p performer: PerformerSuperDirt new.';
		nextPutAll: String cr;
		nextPutAll: String cr.
	performanceScript do: [ :each |
		stream
			nextPutAll: each;
			nextPutAll: String cr ].
	stream close
]
