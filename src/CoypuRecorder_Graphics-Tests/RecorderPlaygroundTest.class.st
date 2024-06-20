Class {
	#name : #RecorderPlaygroundTest,
	#superclass : #TestCase,
	#instVars : [
		'recorderPlayground'
	],
	#category : #'CoypuRecorder_Graphics-Tests'
}

{ #category : #running }
RecorderPlaygroundTest >> setUp [

	super setUp.

	recorderPlayground := RecorderPlayground new.
]

{ #category : #'as yet unclassified' }
RecorderPlaygroundTest >> testLoadButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 3) .
	self assert: recorderPlayground lastButtonPressed equals: 'load'.
]

{ #category : #'as yet unclassified' }
RecorderPlaygroundTest >> testPlayButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 1).
	self assert: recorderPlayground lastButtonPressed equals: 'play'
]

{ #category : #'as yet unclassified' }
RecorderPlaygroundTest >> testSaveButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 4) .
	self assert: recorderPlayground lastButtonPressed equals: 'save'
]

{ #category : #'as yet unclassified' }
RecorderPlaygroundTest >> testStopButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 2).
	self assert: recorderPlayground lastButtonPressed equals: 'stop'
]
