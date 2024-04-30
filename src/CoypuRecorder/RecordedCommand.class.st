Class {
	#name : #RecordedCommand,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'time',
		'delay'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

{ #category : #accessing }
RecordedCommand >> delay: aTimeInSeconds [

delay := aTimeInSeconds
]

{ #category : #'as yet unclassified' }
RecordedCommand >> getPrint: aSavedPerformance [

	^ aSavedPerformance getCommandScript: self print
]

{ #category : #primitives }
RecordedCommand >> getTime: aSavedPerformance [

	^ aSavedPerformance getCommandTime: self time asTime
]

{ #category : #'instance creation' }
RecordedCommand >> initialize [

	super initialize.
	time := DateAndTime now . 
]

{ #category : #printing }
RecordedCommand >> print [

self subclassResponsibility 
]

{ #category : #accessing }
RecordedCommand >> time [

^time 
	
]
