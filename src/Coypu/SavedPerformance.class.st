Class {
	#name : #SavedPerformance,
	#superclass : #OrderedCollection,
	#category : #Coypu
}

{ #category : #adding }
SavedPerformance >> addInstrument: anAnnouncement [
 self add:
		(RecordedInstrument new rythm: anAnnouncement rythm)
]

{ #category : #adding }
SavedPerformance >> lastDirtNotes: anAnnouncement [

	self last dirtNotes: anAnnouncement newDirtNotes
]

{ #category : #adding }
SavedPerformance >> lastSymbol: anAnnouncement [

	self last symbol: anAnnouncement symbol
]

{ #category : #writing }
SavedPerformance >> scriptInTranscript [

	| c |
	c := self scriptList.
	'p := PerformanceRecorder uniqueInstance .' traceCr.
	'p performer: PerformerSuperDirt new.' traceCr.
	'' traceCr.
	c with: self do: [ :each :time |
		('"#At ' , time time asTime asString , ' :"') traceCr.
		('p ' , each) traceCr.
		'' traceCr ]
]

{ #category : #accessing }
SavedPerformance >> scriptList [

	| script |
	script := self collect: [ :each | each print ].
	^ script
]

{ #category : #writing }
SavedPerformance >> writeScriptInTxtFile [

	| x script c stream counter |
	counter := ''.
	c := self scriptList.
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
	c with: self do: [ :each :time |
		stream
			nextPutAll: '"At ';
			nextPutAll: time time asTime asString;
			nextPutAll: ' :"';
			nextPutAll: String cr;
			nextPutAll: 'p ' , each;
			nextPutAll: String cr;
			nextPutAll: String cr ].
	stream close
]
