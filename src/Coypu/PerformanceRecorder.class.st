Class {
	#name : #PerformanceRecorder,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'savedPerformance',
		'announcer'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Coypu-Performance'
}

{ #category : #'instance creation' }
PerformanceRecorder class >> new [

	^ Error new signal:
		  'PerformanceRecorder is a singleton -- Use unique instance instead'
]

{ #category : #accessing }
PerformanceRecorder class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #adding }
PerformanceRecorder >> addInstrument: anAnnouncement [

	savedPerformance add: ((RecordedInstrument new) rythm: anAnnouncement rythm)
]

{ #category : #accessing }
PerformanceRecorder >> announcer [

	^ announcer
]

{ #category : #accessing }
PerformanceRecorder >> freq: aDurationInSeconds [

	savedPerformance add: (RecordedOrder new order:
			 'freq: ' , (1 / (4 * aDurationInSeconds) * 60) asInteger asString
			 , ' bpm.').
	Performance uniqueInstance freq: aDurationInSeconds
]

{ #category : #accessing }
PerformanceRecorder >> lastDirtNotes: anAnnouncement [

	savedPerformance last dirtNotes: anAnnouncement newDirtNotes

]

{ #category : #adding }
PerformanceRecorder >> lastSymbol: anAnnouncement [

	savedPerformance last symbol: anAnnouncement symbol
]

{ #category : #'muting and soloing' }
PerformanceRecorder >> mute: aKeyOrAnArrayOfKeys [

	Performance uniqueInstance mute: aKeyOrAnArrayOfKeys.
	savedPerformance
		add:( RecordedOrder new order: 'mute: ' , '#' , aKeyOrAnArrayOfKeys asString , '.').
]

{ #category : #'LiveCoding - satelliteEvent' }
PerformanceRecorder >> pacaDance [
"NE FONCTIONNE PAS"
	savedPerformance add: (RecordedOrder new order: 'pacaDance').

	"Performance uniqueInstance pacaDance"
]

{ #category : #accessing }
PerformanceRecorder >> performer: aPerformer [

	savedPerformance := OrderedCollection new.
	announcer := Announcer new.
	announcer when: RythmAnnouncement send: #addInstrument: to: self.
	announcer when: SymbolAnnouncement send: #lastSymbol: to: self.
	announcer when: DirtNotesAnnouncement send: #lastDirtNotes: to: self.
	Performance uniqueInstance performer: aPerformer
]

{ #category : #playing }
PerformanceRecorder >> play [
	"NE FONCTIONNE PAS"

	savedPerformance add: (RecordedOrder new order: 'play.').
	"Performance uniqueInstance play"
]

{ #category : #playing }
PerformanceRecorder >> playFor: aNumberOfSteps [

	savedPerformance add: (RecordedOrder new order:
			 'playFor: ' , (aNumberOfSteps / 16) asString , ' bars.').
	Performance uniqueInstance playFor: aNumberOfSteps
]

{ #category : #accessing }
PerformanceRecorder >> savedPerformance [

	^ savedPerformance
]

{ #category : #'as yet unclassified' }
PerformanceRecorder >> scriptInTranscript [

	| c |
	c := self scriptList.
	'p := PerformanceRecorder uniqueInstance .' traceCr.
	'p performer: PerformerSuperDirt new.' traceCr.
	'' traceCr.
	c with: savedPerformance do: [ :each :time |
		('"#At ' , time time asTime asString , ' :"') traceCr.
		('p ' , each) traceCr.
		'' traceCr ]
]

{ #category : #'as yet unclassified' }
PerformanceRecorder >> scriptList [

	| script |
	script := savedPerformance collect: [ :each | each print ].
	^ script
]

{ #category : #'muting and soloing' }
PerformanceRecorder >> solo: aKeyOrAnArrayOfKeys [

	Performance uniqueInstance solo: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedOrder new order:
			 'solo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : #accessing }
PerformanceRecorder >> stop [

	savedPerformance add: (RecordedOrder new order: 'stop.').
	Performance uniqueInstance stop
]

{ #category : #'LiveCoding - Performance' }
PerformanceRecorder >> unsolo: aKeyOrAnArrayOfKeys [

	Performance uniqueInstance unsolo: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedOrder new order:
			 'unsolo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : #writing }
PerformanceRecorder >> writeScriptInTxtFile [

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
	           , DateAndTime now asDate asString ,'(',counter asString
	           ,')', 'txt') asFileReference.

	stream := script writeStream.
	stream nextPutAll: 'p := PerformanceRecorder uniqueInstance.'.
	stream
		nextPutAll: String cr;
		nextPutAll: String cr;
		nextPutAll: 'p performer: PerformerSuperDirt new.';
		nextPutAll: String cr;
		nextPutAll: String cr.
	c with: savedPerformance do: [ :each :time |
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
