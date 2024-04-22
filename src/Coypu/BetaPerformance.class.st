Class {
	#name : #BetaPerformance,
	#superclass : #Performance,
	#type : #variable,
	#instVars : [
		'lastRythm',
		'savedPerformance',
		'counter',
		'dirtNotes',
		'announcer'
	],
	#category : #'Coypu-Performance'
}

{ #category : #adding }
BetaPerformance >> addInstrument: anAnnouncement [

	| k l |
	k := anAnnouncement newSymbol.
	l := lastRythm , ' to: #' , k,'.'.
	"dirtNotes ifNotNil: [l:=l,'; ','dirtNotes: ''',dirtNotes,''''.
	dirtNotes := nil.]."
	savedPerformance at: counter put: l.
	counter := counter + 1
]

{ #category : #adding }
BetaPerformance >> announcer [

^announcer.
]

{ #category : #accessing }
BetaPerformance >> freq: aDurationInSeconds [
super freq: aDurationInSeconds.
savedPerformance at: counter put: 'freq: ', (((1/(4*aDurationInSeconds))*60)asInteger asString),' bpm'.
counter := counter+1.
]

{ #category : #accessing }
BetaPerformance >> lastDirtNotes [

^dirtNotes
]

{ #category : #accessing }
BetaPerformance >> lastDirtNotes: anAnnouncement [

savedPerformance at: counter-1 put: (savedPerformance at: counter-1), '; ','dirtNotes: ''',anAnnouncement newDirtNotes,'''.'.
]

{ #category : #accessing }
BetaPerformance >> lastRythm [

^ lastRythm. 

]

{ #category : #adding }
BetaPerformance >> lastRythm:  anAnnouncement [
lastRythm := anAnnouncement newRythm.
]

{ #category : #'muting and soloing' }
BetaPerformance >> mute: aKeyOrAnArrayOfKeys [
Performance uniqueInstance mute: aKeyOrAnArrayOfKeys.
savedPerformance at: counter put: 'mute: ','#',aKeyOrAnArrayOfKeys asString,'.'.
counter := counter+1.

]

{ #category : #accessing }
BetaPerformance >> performer: aPerformer [
super performer: aPerformer.
savedPerformance := Array new:50.
counter := 1.
announcer := Announcer new.
announcer when: RythmAnnouncement  send: #lastRythm: to: self.
announcer when: SymbolAnnouncement send: #addInstrument: to: self.
announcer when: DirtNotesAnnouncement send: #lastDirtNotes: to:self.

]

{ #category : #accessing }
BetaPerformance >> play [
savedPerformance at: counter put: 'play'.
counter := counter+1.
super play.
]

{ #category : #accessing }
BetaPerformance >> playFor: aNumberOfSteps [
savedPerformance at: counter put: 'playFor: ',((aNumberOfSteps/16) asString),' bars'.
counter := counter+1.
super playFor: aNumberOfSteps.
]

{ #category : #accessing }
BetaPerformance >> savedPerformance [

^ savedPerformance.
]

{ #category : #'muting and soloing' }
BetaPerformance >> solo: aKeyOrAnArrayOfKeys [
Performance uniqueInstance solo: aKeyOrAnArrayOfKeys.
savedPerformance at: counter put: 'solo: ','#',aKeyOrAnArrayOfKeys asString,'.'.
counter := counter+1.
]

{ #category : #accessing }
BetaPerformance >> stop [
savedPerformance at: counter put: 'stop'.
Performance uniqueInstance stop.

]

{ #category : #'LiveCoding - Performance' }
BetaPerformance >> unsolo: aKeyOrAnArrayOfKeys [
Performance uniqueInstance unsolo:aKeyOrAnArrayOfKeys.
savedPerformance at: counter put: 'unsolo: ','#',aKeyOrAnArrayOfKeys asString,'.'.
counter := counter+1.


]
