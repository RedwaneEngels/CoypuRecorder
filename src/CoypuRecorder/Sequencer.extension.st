Extension { #name : #Sequencer }

{ #category : #'*CoypuRecorder' }
Sequencer >> to: aSymbol atTime: aTime [
	" assign sequencer to the performance at aSymbol. if a sound for SuperDirt is not specified, the symbol is used for sound name"

	| sampleFolder sampleIndex a b |
	(Delay forSeconds: aTime) wait.
	self seqKey: aSymbol asString.
	"For SuperDirt"
	self dirtMessage at: '_id' put: self seqKey.
	self dirtMessage at: 'orbit' put: self orbit.
	(self dirtMessage includesKey: 's')
		ifFalse: [
		self dirtMessage at: 's' put: aSymbol asString asDirtArray ]
		ifTrue: [  ].
	a := PerformanceRecorder uniqueInstance announcer.
	b := SymbolAnnouncement new.
	b symbol: self seqKey.
	a announce: b.

	"For Polyphony"
	seqChords
		ifNil: [ Performance uniqueInstance at: aSymbol put: self ]
		ifNotNil: [
		Performance uniqueInstance at: aSymbol put: self asPolySeq ].


	"For PerformerPhaust"
	Performance uniqueInstance performer class = PerformerPhaust ifTrue: [
		self phaustGateDestination: self seqKey , 'Gate'.
		self phaustNoteDestination: self seqKey , 'Note' ]
]
