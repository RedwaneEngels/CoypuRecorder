Class {
	#name : #PerformanceRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder'
	],
	#category : #'Coypu-Performance'
}

{ #category : #running }
PerformanceRecorderTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt  new
]

{ #category : #tests }
PerformanceRecorderTest >> testAddInstrument [

self assert: performanceRecorder savedPerformance isEmpty equals: true.

performanceRecorder addInstrument: (RythmAnnouncement new rythm: 'upbeats').

self assert: performanceRecorder savedPerformance isEmpty equals: false.

self assert: performanceRecorder savedPerformance last rythm equals: 'upbeats'
]

{ #category : #tests }
PerformanceRecorderTest >> testFreqInSavedPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	performanceRecorder freq: 138 bpm.

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'freq: 138 bpm.'
]

{ #category : #tests }
PerformanceRecorderTest >> testLastDirtNotesInPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.
		
	performanceRecorder addInstrument:
		(RythmAnnouncement new rythm: 'upbeats').
	performanceRecorder lastDirtNotes:
		(DirtNotesAnnouncement new newDirtNotes: '4').
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last dirtNotes
		equals: '4'
]

{ #category : #tests }
PerformanceRecorderTest >> testLastSymbolInPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	performanceRecorder addInstrument:
		(RythmAnnouncement new rythm: 'upbeats').
	performanceRecorder lastSymbol:
		(SymbolAnnouncement new symbol: '#bb').

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last symbol
		equals: '#bb'
]

{ #category : #tests }
PerformanceRecorderTest >> testMuteInPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'mute: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlayForInSavedPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	performanceRecorder playFor: 12 bars.

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'playFor: 12 bars.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlayInSavedPerformance [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	performanceRecorder play.

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'play.'
]
