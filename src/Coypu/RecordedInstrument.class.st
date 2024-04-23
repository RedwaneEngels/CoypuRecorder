Class {
	#name : #RecordedInstrument,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'dirtNotes',
		'rythm',
		'symbol'
	],
	#category : #Coypu
}

{ #category : #accessing }
RecordedInstrument >> dirtNotes [

^	dirtNotes
]

{ #category : #accessing }
RecordedInstrument >> dirtNotes: aDirtNotes [

dirtNotes := aDirtNotes
]

{ #category : #'instance creation' }
RecordedInstrument >> newRythm: aRythm [ 

	rythm := aRythm.

]

{ #category : #'instance creation' }
RecordedInstrument >> newRythm: aRythm newSymbol: aSymbol [

	rythm := aRythm.
	symbol  := aSymbol
]

{ #category : #'instance creation' }
RecordedInstrument >> newSymbol: aSymbol [


	symbol := aSymbol
]

{ #category : #printing }
RecordedInstrument >> print [

	| m |
	m := rythm , ' to: #' , symbol , '.'.
	dirtNotes ifNotNil: [
		m := m allButLast , '; ' , 'dirtNotes: ''',dirtNotes,'''. ' ].
	^ m
]

{ #category : #'instance creation' }
RecordedInstrument >> rythm [
^rythm 
]

{ #category : #'instance creation' }
RecordedInstrument >> symbol [

	^ symbol 
]
