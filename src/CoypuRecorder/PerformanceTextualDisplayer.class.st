Class {
	#name : #PerformanceTextualDisplayer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'performanceScript',
		'performanceTimes'
	],
	#category : #CoypuRecorder
}

{ #category : #accessing }
PerformanceTextualDisplayer >> displayInTranscript [

	'p := PerformanceRecorder uniqueInstance .' traceCr.
	'p performer: PerformerSuperDirt new.' traceCr.
	'' traceCr.
	performanceScript with: performanceTimes do: [ :each :time |
		('"#At ' , time asTime asString , ' :"') traceCr.
		('p ' , each) traceCr.
		'' traceCr ]
]

{ #category : #accessing }
PerformanceTextualDisplayer >> performanceScript: anOrderedCollection [

performanceScript := anOrderedCollection 
]

{ #category : #accessing }
PerformanceTextualDisplayer >> performanceTimes: anOrderedCollection [

	performanceTimes := anOrderedCollection
]

{ #category : #visiting }
PerformanceTextualDisplayer >> visitAPerformanceRecorder: aSavedPerformance [

	aSavedPerformance scriptForDisplayer: self
]

{ #category : #accessing }
PerformanceTextualDisplayer >> writeScriptInTxtFile [

	| x script stream counter |
	counter := ''.
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	[
	(x / 'PerformanceScripts' / 'Performance of the '
	 , DateAndTime now asDate asString , '(' , counter asString , ')'
	 , 'txt') asFileReference isFile ] whileTrue: [
		counter = '' ifTrue: [ counter := 0 ].
		counter := counter + 1 ].
	script := (x / 'PerformanceScripts' / 'Performance of the '
	           , DateAndTime now asDate asString , '(' , counter asString
	           , ')' , 'txt') asFileReference.

	stream := script writeStream.
	stream nextPutAll: 'p := PerformanceRecorder uniqueInstance.'.
	stream
		nextPutAll: String cr;
		nextPutAll: String cr;
		nextPutAll: 'p performer: PerformerSuperDirt new.';
		nextPutAll: String cr;
		nextPutAll: String cr.
	performanceScript  with: performanceTimes  do: [ :each :time |
		stream
			nextPutAll: '"At ';
			nextPutAll: time asTime asString;
			nextPutAll: ' :"';
			nextPutAll: String cr;
			nextPutAll: 'p ' , each;
			nextPutAll: String cr;
			nextPutAll: String cr ].
	stream close
]
