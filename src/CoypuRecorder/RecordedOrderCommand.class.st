Class {
	#name : #RecordedOrderCommand,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'order'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

{ #category : #accessing }
RecordedOrderCommand >> order [

	^order
]

{ #category : #accessing }
RecordedOrderCommand >> order: anOrder [

order := anOrder
]

{ #category : #printing }
RecordedOrderCommand >> print [

	| p |
	p := 'p ' , self order asString.
	delay ifNotNil: [
		p := (p includesSubstring: ':')
			     ifFalse: [
			     (p allButLast) , 'AtTime: ' , delay asString , '.' ]
			     ifTrue: [ p allButLast , ' atTime: ' , delay asString , '.' ] ].
	^ p
]
