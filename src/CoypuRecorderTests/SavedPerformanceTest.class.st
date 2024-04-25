Class {
	#name : #SavedPerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder'
	],
	#category : #'CoypuRecorderTests-Tests'
}

{ #category : #running }
SavedPerformanceTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder
		                       uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt new
]

{ #category : #tests }
SavedPerformanceTest >> testAddInstrument [

	self
		assert: performanceRecorder savedPerformance collectionOfCommands  isEmpty
		equals: true.

	16 upbeats to: #bd.

	self
		assert: performanceRecorder savedPerformance collectionOfCommands isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance collectionOfCommands last rythm
		equals: '16 upbeats'
]

{ #category : #tests }
SavedPerformanceTest >> testLastDirtNotes [

	self
		assert: performanceRecorder savedPerformance collectionOfCommands isEmpty
		equals: true.

	16 upbeats to: #bd; dirtNotes: '4'.
	self
		assert: performanceRecorder savedPerformance collectionOfCommands isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance collectionOfCommands last dirtNotes
		equals: '4'.
		
	8 upbeats dirtNotes: '8'; to: #bass3.
	
	self
			assert: performanceRecorder savedPerformance collectionOfCommands last dirtNotes
		equals: '8'.

]

{ #category : #tests }
SavedPerformanceTest >> testLastSymbol [

	self
		assert: performanceRecorder savedPerformance collectionOfCommands isEmpty
		equals: true.

	16 upbeats to: #bb.

	self
		assert: performanceRecorder savedPerformance collectionOfCommands isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance collectionOfCommands last symbol
		equals: 'bb'
]
