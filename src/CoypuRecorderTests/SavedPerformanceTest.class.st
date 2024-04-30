Class {
	#name : #SavedPerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder'
	],
	#category : #'CoypuRecorderTests-Tests'
}

{ #category : #tests }
SavedPerformanceTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : #running }
SavedPerformanceTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder
		                       uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt new
]

{ #category : #tests }
SavedPerformanceTest >> testAddInstrument [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bd.

	self assert: self commands isEmpty equals: false.

	self assert: self commands last rythm equals: '16 upbeats'
]

{ #category : #tests }
SavedPerformanceTest >> testLastDirtNotes [

	self assert: self commands isEmpty equals: true.

	16 upbeats
		to: #bd;
		dirtNotes: '4'.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last dirtNotes equals: '4'.

	8 upbeats
		dirtNotes: '8';
		to: #bass3.

	self assert: self commands last dirtNotes equals: '8'
]

{ #category : #tests }
SavedPerformanceTest >> testLastSymbol [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.

	self assert: self commands isEmpty equals: false.

	self assert: self commands last symbol equals: 'bb'
]

{ #category : #tests }
SavedPerformanceTest >> testRightNumberOfCommandsInSavedPerformance [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.

	performanceRecorder freq: 138 bpm.

	performanceRecorder playFor: 12 bars.

	performanceRecorder stop.

	self assert: self commands isEmpty equals: false.

	self assert: self commands size equals: 4.
	
]
