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

{ #category : #calculating }
SavedPerformance >> absoluteToDelay [

	| delays times |
	times := self getTimes.
	delays := OrderedCollection new.

	1 to: times size - 1 do: [ :i |
		delays add: (times at: i + 1) asSeconds - (times at: i) asSeconds ].

	delays addFirst: 0.

	^ delays
]

{ #category : #calculating }
SavedPerformance >> absoluteToRelative [

	| times |
	times := self getTimes.
	^ times collect: [ :each | (each asSeconds - times first asSeconds ) asString ]
]

{ #category : #adding }
SavedPerformance >> add: anObject [

	collectionOfCommands add: anObject
]

{ #category : #adding }
SavedPerformance >> addInstrument: anAnnouncement [

	collectionOfCommands add: (RecordedInstrumentCommand new rythm: anAnnouncement rythm)
]

{ #category : #accessing }
SavedPerformance >> collectionOfCommands [
^	collectionOfCommands
]

{ #category : #adding }
SavedPerformance >> collectionOfCommands: anOrderedCollection [

collectionOfCommands := anOrderedCollection 
]

{ #category : #visiting }
SavedPerformance >> getCommandScript: aString [

^ aString 
]

{ #category : #visiting }
SavedPerformance >> getCommandTime: aString [

^ aString
]

{ #category : #'as yet unclassified' }
SavedPerformance >> getScripts [

	| scripts |
	scripts := collectionOfCommands collect: [ :each |
		           self visitCommandToGetScript: each ].
	scripts
		addFirst: 'p performer: PerformerSuperDirt new.' , String cr;
		addFirst: 'p := PerformanceRecorder uniqueInstance.', String cr, String cr.

	^ scripts
]

{ #category : #'as yet unclassified' }
SavedPerformance >> getTimes [

^ collectionOfCommands collect: [ :each |
		           self visitCommandToGetTime: each ].

]

{ #category : #adding }
SavedPerformance >> lastDirtNotes: anAnnouncement [

	collectionOfCommands last dirtNotes: anAnnouncement newDirtNotes
]

{ #category : #adding }
SavedPerformance >> lastSymbol: anAnnouncement [

collectionOfCommands  last symbol: anAnnouncement symbol
]

{ #category : #visitors }
SavedPerformance >> scriptForReplayer: aDisplayer [

	aDisplayer performanceScript: self getScripts
]

{ #category : #visitors }
SavedPerformance >> scriptWithDelayTimeForReplayer: aReplayer [

	| delay|
	delay := self absoluteToDelay.

	collectionOfCommands with: delay do: [ :each :d | each delay: d ].
	aReplayer performanceScript:  self getScripts.
]

{ #category : #visitors }
SavedPerformance >> scriptWithRelativeTimeForReplayer: aDisplayer [

	| scripts relativetimes |
	relativetimes := self absoluteToRelative.
	scripts := ( self getScripts allButFirst:2 ) with: relativetimes
		           collect: [ :each :time |
			           '"//At the ' , time , time suffixeNumber , ' second\\"'
			           , String cr , each ].
	scripts
		addFirst: 'p performer: PerformerSuperDirt new.' , String cr;
		addFirst: 'p := PerformanceRecorder uniqueInstance.'.
	aDisplayer performanceScript: scripts
]

{ #category : #visitors }
SavedPerformance >> scriptWithTimeForReplayer: aDisplayer [

	| scripts |
	scripts := (self getScripts allButFirst: 2)
		           with: self getTimes
		           collect: [ :each :times |
		           '"#At ' , times asString , ' :"' , String cr , each ].
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
