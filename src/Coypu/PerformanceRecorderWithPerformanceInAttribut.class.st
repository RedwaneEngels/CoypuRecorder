Class {
	#name : #PerformanceRecorderWithPerformanceInAttribut,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'savedPerformance',
		'announcer',
		'performance'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Coypu-Performance'
}

{ #category : #'instance creation' }
PerformanceRecorderWithPerformanceInAttribut class >> new [

	^ Error new signal:
		  'PerformanceRecorder is a singleton -- Use unique instance instead'
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> Dictionary [

	^ performance dictionary
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> activeDSP [ 

^ Performance uniqueInstance activeDSP
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> activeDSP: aDSP [

	performance activeDSP: aDSP
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> activeProcess [

	^ performance activeProcess
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> activeProcess: anObject [

	performance activeProcess: anObject
]

{ #category : #adding }
PerformanceRecorderWithPerformanceInAttribut >> add: aSequencer channel: anIntegerBetween1And16 [

	performance
		add: aSequencer
		channel: anIntegerBetween1And16
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> announcer [

	^ announcer
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> at: key put: anObject [

	performance at: key put: anObject
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> backup [

	^ performance backup
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> backup: anObject [

	performance backup: anObject
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> bpm [

	^ performance bpm
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> bpm: aRateInSeconds [

	performance bpm: aRateInSeconds
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> canvas [

	^ performance canvas
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> canvas: aRSCanvas [

	performance canvas: aRSCanvas
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> dirtMIDIDevice [
	"select a SuperDirt MIDI device for the Performance"

	^ performance dirtMIDIDevice
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> dirtMIDIDevice: aString [
	"select a SuperDirt MIDI device for the Performance"

	performance dirtMIDIDevice: aString
]

{ #category : #'accessing - structure variables' }
PerformanceRecorderWithPerformanceInAttribut >> freq [

	^ performance freq
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> freq1: anObject [

	performance freq1: anObject
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> freq: aDurationInSeconds [

	savedPerformance add: (RecordedOrderCommand new order:
			 'freq: ' , (1 / (4 * aDurationInSeconds) * 60) asInteger asString
			 , ' bpm.').
	performance freq: aDurationInSeconds
]

{ #category : #'LiveCoding - Performance' }
PerformanceRecorderWithPerformanceInAttribut >> incrementTransportStep [

	performance incrementTransportStep
]

{ #category : #initialization }
PerformanceRecorderWithPerformanceInAttribut >> initialize: aSize [

	performance initialize: aSize
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> isPerformance [ 

performance isPerformance 
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> length [

	performance length
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> mute: aKeyOrAnArrayOfKeys [

	performance mute: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedOrderCommand new order:
			 'mute: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> muteAll [

	savedPerformance
		add:( RecordedOrderCommand new
		order: 'muteAll.').
	Performance uniqueInstance muteAll
		
]

{ #category : #'LiveCoding - satelliteEvent' }
PerformanceRecorderWithPerformanceInAttribut >> pacaDance [

	savedPerformance add: (RecordedOrderCommand new order: 'pacaDance').

	performance pacaDance
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> performance [

^ performance 
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> performance: aPerformance [

performance := aPerformance
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> performer [

	^ performance performer
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> performer: aPerformer [

	performance := Performance uniqueInstance.
	savedPerformance := SavedPerformance new.
	announcer := PerformanceRecorder uniqueInstance  announcer.
	announcer
		when: RythmAnnouncement
		send: #addInstrument:
		to: savedPerformance.
	announcer
		when: SymbolAnnouncement
		send: #lastSymbol:
		to: savedPerformance.
	announcer
		when: DirtNotesAnnouncement
		send: #lastDirtNotes:
		to: savedPerformance.
	performance performer: aPerformer
]

{ #category : #playing }
PerformanceRecorderWithPerformanceInAttribut >> play [


	savedPerformance add: (RecordedOrderCommand new order: 'play.').
	performance play
]

{ #category : #playing }
PerformanceRecorderWithPerformanceInAttribut >> playFor: aNumberOfSteps [

	savedPerformance add: (RecordedOrderCommand new order:
			 'playFor: ' , (aNumberOfSteps / 16) asString , ' bars.').
	performance playFor: aNumberOfSteps
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> playKymaSequencFor: aNumberOfSteps [

	performance playKymaSequencFor: aNumberOfSteps
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps [

	performance
		playKymaSequenceAt: aRateInSeconds
		for: aNumberOfSteps
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps [

	performance
		playLocalSequenceAt: aRateInSeconds
		for: aNumberOfSteps
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> remove: aKey [

	performance remove: aKey
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> resetAllSequencers [

	performance resetAllSequencers
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> restore [

	savedPerformance add: (RecordedOrderCommand new order: 'restore.').
	performance restore
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> rsGroupDictionary [

	^ performance rsGroupDictionary
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> rsGroupDictionary: anRSGroupDictionary [

	performance rsGroupDictionary: anRSGroupDictionary
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> savedPerformance [

	^ savedPerformance
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> solo: aKeyOrAnArrayOfKeys [

	performance solo: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedOrderCommand new order:
			 'solo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> stop [

	savedPerformance add: (RecordedOrderCommand new order: 'stop.').
	performance stop
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> swap: firstKey with: secondKey [

	performance swap: firstKey with: secondKey
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> transportStep [

	^ performance transportStep
]

{ #category : #'muting and soloing' }
PerformanceRecorderWithPerformanceInAttribut >> transportStep: anInteger [

	performance transportStep: anInteger
]

{ #category : #'LiveCoding - Performance' }
PerformanceRecorderWithPerformanceInAttribut >> unsolo: aKeyOrAnArrayOfKeys [

	performance unsolo: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedOrderCommand new order:
			 'unsolo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> visualization [

	^ performance visualization
]

{ #category : #accessing }
PerformanceRecorderWithPerformanceInAttribut >> visualization: anObject [

	performance visualization: anObject
]
