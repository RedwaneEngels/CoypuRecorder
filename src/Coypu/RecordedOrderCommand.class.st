Class {
	#name : #RecordedOrderCommand,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'order'
	],
	#category : #Coypu
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

	^ self order asString
]
