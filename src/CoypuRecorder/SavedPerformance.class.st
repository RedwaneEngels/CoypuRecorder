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
SavedPerformance >> absoluteToRelative: anOrderedCollection [
|start absolute|

start := (anOrderedCollection at: 1) asSeconds.

absolute := OrderedCollection new.
absolute add: '0'.
anOrderedCollection removeFirst.
anOrderedCollection do: [:each |absolute add: (each asSeconds - start) asString ].

^  absolute
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
SavedPerformance >> scriptForDisplayer: aDisplayer [

	| scripts |
	scripts := collectionOfCommands collect: [ :each |'p '
		           , (self visitCommandToGetScript: each) , String cr ].

	aDisplayer performanceScript: scripts
]

{ #category : #accessing }
SavedPerformance >> scriptWithRelativeTimeForDisplayer: aDisplayer [

	| scripts relativetimes |
	relativetimes := self absoluteToRelative:
		                 (collectionOfCommands collect: [ :each |
			                  self visitCommandToGetTime: each ]).
	scripts := collectionOfCommands
		           with: relativetimes
		           collect: [ :each :time |
			           '"#At the ' , time ,time suffixeNumber ,' second :"' , String cr , 'p '
			           , (self visitCommandToGetScript: each) , String cr ].

	aDisplayer performanceScript: scripts
]

{ #category : #accessing }
SavedPerformance >> scriptWithTimeForDisplayer: aDisplayer [

	| scripts |
	scripts := collectionOfCommands collect: [ :each |
		           '"#At ' , (self visitCommandToGetTime: each) asString , ' :"'
		           , String cr , 'p ' , (self visitCommandToGetScript: each)
		           , String cr ].

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
