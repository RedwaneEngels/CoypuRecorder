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

{ #category : #accessing }
PerformanceTextualDisplayer >> performanceScript: anOrderedCollection [

performanceScript := anOrderedCollection 
]

{ #category : #visiting }
PerformanceTextualDisplayer >> visitASavedPerformance: aSavedPerformance [

	aSavedPerformance scriptForDisplayer: self
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
