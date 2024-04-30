Class {
	#name : #SavedPerformance,
	#superclass : #Object,
	#instVars : [
		'collectionOfCommands',
		'aSavedPerformance'
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

{ #category : #'as yet unclassified' }
SavedPerformance >> absoluteToDelay [

	| times |
	times := OrderedCollection new.

	1 to: collectionOfCommands size - 1 do: [ :i |
		times add:
			(self visitCommandToGetTime: (collectionOfCommands at: i + 1))
				asSeconds
			-
			(self visitCommandToGetTime: (collectionOfCommands at: i))
				asSeconds.
		((self visitCommandToGetTime: (collectionOfCommands at: i + 1))
			 asSeconds asString , ' - '
		 , (self visitCommandToGetTime: (collectionOfCommands at: i))
				 asSeconds asString) traceCr ].

	times addFirst: 0.
	times traceCr.

	^ times
]

{ #category : #'as yet unclassified' }
SavedPerformance >> absoluteToRelative: anOrderedCollection [

	| start relative |
	start := (anOrderedCollection at: 1) asSeconds.

	relative  := OrderedCollection new.
	relative  add: '0'.
	anOrderedCollection removeFirst.
	anOrderedCollection do: [ :each |
		relative  add: (each asSeconds - start) asString ].

	^ relative 
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

{ #category : #'as yet unclassified' }
SavedPerformance >> getCommandScript: aString [

^ aString 
]

{ #category : #'as yet unclassified' }
SavedPerformance >> getCommandTime: aString [

^ aString
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
SavedPerformance >> scriptForReplayer: aDisplayer [

	| scripts |
	scripts := collectionOfCommands collect: [ :each |
		           (self visitCommandToGetScript: each) ].
	scripts
		addFirst:
			'p performer: PerformerSuperDirt new.' , String cr ;
		addFirst: 'p := PerformanceRecorder uniqueInstance.'.

	aDisplayer performanceScript: scripts
]

{ #category : #'as yet unclassified' }
SavedPerformance >> scriptWithDelayTimeForReplayer: aReplayer [

	| delay scripts |
	delay := self absoluteToDelay.

	collectionOfCommands with: delay do: [ :each :d | each delay: d ].

	scripts := collectionOfCommands collect: [ :each |
		           (self visitCommandToGetScript: each),
		           String cr , String cr ].

	scripts
		addFirst: 'p performer: PerformerSuperDirt new.' , String cr;
		addFirst:
			'p := PerformanceRecorder uniqueInstance.' , String cr , String cr.

	aReplayer performanceScript: scripts
]

{ #category : #accessing }
SavedPerformance >> scriptWithRelativeTimeForReplayer: aDisplayer [

	| scripts relativetimes |
	relativetimes := self absoluteToRelative:
		                 (collectionOfCommands collect: [ :each |
			                  self visitCommandToGetTime: each ]).
	scripts := collectionOfCommands
		           with: relativetimes
		           collect: [ :each :time |
			           '"//At the ' , time , time suffixeNumber , ' second\\"'
			           , String cr , (self visitCommandToGetScript: each)].
	scripts
		addFirst: 'p performer: PerformerSuperDirt new.' , String cr;
		addFirst: 'p := PerformanceRecorder uniqueInstance.'.
	aDisplayer performanceScript: scripts
]

{ #category : #accessing }
SavedPerformance >> scriptWithTimeForReplayer: aDisplayer [

	| scripts |
	scripts := collectionOfCommands collect: [ :each |
		           '"#At ' , (self visitCommandToGetTime: each)asString
		           , ' :"' , String cr
		           , (self visitCommandToGetScript: each) ].
	scripts
		addFirst: 'p performer: PerformerSuperDirt new.' , String cr;
		addFirst: 'p := PerformanceRecorder uniqueInstance.'.
	aDisplayer performanceScript: scripts
]

{ #category : #visiting }
SavedPerformance >> visitCommandToGetScript: aRecordedCommand [

	^ aRecordedCommand getPrint: self
]

{ #category : #visiting }
SavedPerformance >> visitCommandToGetTime: aRecordedCommand [

	^ aRecordedCommand getTime: self
]
