Class {
	#name : #RecordedCommand,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'time'
	],
	#category : #'CoypuRecorder-RecordedCommand'
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
