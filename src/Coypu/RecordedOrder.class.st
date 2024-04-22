Class {
	#name : #RecordedOrder,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'order'
	],
	#category : #Coypu
}

{ #category : #accessing }
RecordedOrder >> order [

	^order
]

{ #category : #accessing }
RecordedOrder >> order: anOrder [

order := anOrder
]

{ #category : #printing }
RecordedOrder >> print [

	^ self order asString
]
