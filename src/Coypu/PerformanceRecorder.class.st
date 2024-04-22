Class {
	#name : #PerformanceRecorder,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'lastRythm',
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

	| k l |
	k := anAnnouncement newSymbol.
	l := RecordedInstrument new.
	l newRythm: lastRythm  newSymbol: k.
	savedPerformance add:  l.
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

{ #category : #accessing }
PerformanceRecorder >> lastRythm [

	^ lastRythm
]

{ #category : #accessing }
PerformanceRecorder >> lastRythm: anAnnouncement [

	lastRythm := anAnnouncement newRythm
]

{ #category : #'muting and soloing' }
PerformanceRecorder >> mute: aKeyOrAnArrayOfKeys [

	Performance uniqueInstance mute: aKeyOrAnArrayOfKeys.
	savedPerformance
		add:( RecordedOrder new order: 'mute: ' , '#' , aKeyOrAnArrayOfKeys asString , '.').
]

{ #category : #accessing }
PerformanceRecorder >> performer: aPerformer [

	savedPerformance := OrderedCollection new.
	announcer := Announcer new.
	announcer when: RythmAnnouncement send: #lastRythm: to: self.
	announcer when: SymbolAnnouncement send: #addInstrument: to: self.
	announcer when: DirtNotesAnnouncement send: #lastDirtNotes: to: self.
	Performance uniqueInstance performer: aPerformer
]

{ #category : #playing }
PerformanceRecorder >> play [

	savedPerformance add: (RecordedOrder new order: 'play.').
	Performance uniqueInstance play
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
PerformanceRecorder >> savedPerformanceScript [

	| script |
	script := savedPerformance collect: [ :each | each print ].
	^ script
]

{ #category : #'as yet unclassified' }
PerformanceRecorder >> savedPerformanceScriptInTranscript [

	| c |
	c := self savedPerformanceScript.
	'p := PerformanceRecorder uniqueInstance .' traceCr.
	'p performer: PerformerSuperDirt new.' traceCr.
	'' traceCr.
	c with: savedPerformance do: [ :each :time |
		('"#At ' , time time asTime asString , ' :"') traceCr.
		('p ' , each) traceCr.
		'' traceCr ]
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
