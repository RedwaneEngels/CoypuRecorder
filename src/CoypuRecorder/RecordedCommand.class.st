Class {
	#name : #RecordedCommand,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'time'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

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
