Class {
	#name : #RecordedCommand,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'time'
	],
	#category : #'Coypu-Performance'
}

{ #category : #'instance creation' }
RecordedCommand >> initialize [

	super initialize.
	time := DateAndTime now . 
]

{ #category : #accessing }
RecordedCommand >> time [

^time 
	
]
