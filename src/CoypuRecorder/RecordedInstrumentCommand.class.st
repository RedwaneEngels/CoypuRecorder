Class {
	#name : #RecordedInstrumentCommand,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'dirtNotes',
		'rythm',
		'symbol'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

{ #category : #accessing }
RecordedInstrumentCommand >> dirtNotes [

^	dirtNotes
]

{ #category : #accessing }
RecordedInstrumentCommand >> dirtNotes: aDirtNotes [

dirtNotes := aDirtNotes
]

{ #category : #printing }
RecordedInstrumentCommand >> print [

	| m |
	m := rythm , ' to: #' , symbol asString , '.'.
	delay ifNotNil: [
		m := m allButLast , ' atTime: ' ,delay asString , '.' ].
	dirtNotes ifNotNil: [
		m := m allButLast , '; ' , 'dirtNotes: ''' , dirtNotes , '''.' ].
	^ m
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> rythm [
^rythm 
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> rythm: aRythm [ 

	rythm := aRythm.

]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> symbol [

	^ symbol 
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> symbol: aSymbol [


	symbol := aSymbol
]
