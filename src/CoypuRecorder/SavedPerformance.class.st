Class {
	#name : #SavedPerformance,
	#superclass : #Object,
	#instVars : [
		'collectionOfCommands'
	],
	#category : #'CoypuRecorder-savedPerformance'
}

{ #category : #'instance creation' }
SavedPerformance class >> new [

	| x |
	x := super new.

	x collectionOfCommands: OrderedCollection new.
	
^x
]

{ #category : #adding }
SavedPerformance >> add: anObject [

	collectionOfCommands add: anObject
]

{ #category : #adding }
SavedPerformance >> addInstrument: anAnnouncement [

	collectionOfCommands add: (RecordedInstrumentCommand new rythm: anAnnouncement rythm)
]

{ #category : #adding }
SavedPerformance >> collectionOfCommands [
^	collectionOfCommands
]

{ #category : #adding }
SavedPerformance >> collectionOfCommands: anOrderedCollection [

collectionOfCommands := anOrderedCollection 
]

{ #category : #adding }
SavedPerformance >> lastDirtNotes: anAnnouncement [

	collectionOfCommands last dirtNotes: anAnnouncement newDirtNotes
]

{ #category : #adding }
SavedPerformance >> lastSymbol: anAnnouncement [

collectionOfCommands  last symbol: anAnnouncement symbol
]

{ #category : #accessing }
SavedPerformance >> scriptListForDisplayer: aDisplayer [
| scripts  times |
	scripts := collectionOfCommands collect: [ :each | each print ].
	times := collectionOfCommands collect: [:each | each time  ].
	
aDisplayer performanceScript: scripts.
aDisplayer performanceTimes: times.
]
