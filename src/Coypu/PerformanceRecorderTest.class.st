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
PerformanceRecorderTest >> testFreq [

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
PerformanceRecorderTest >> testMute [

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
PerformanceRecorderTest >> testPlay [

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

{ #category : #tests }
PerformanceRecorderTest >> testPlayFor [

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
PerformanceRecorderTest >> testRestore [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	performanceRecorder restore.
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'restore.'
]

{ #category : #tests }
PerformanceRecorderTest >> testSolo [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'solo: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testStop [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	16 upbeats to: #bb.
	performanceRecorder stop.
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'stop.'
]

{ #category : #tests }
PerformanceRecorderTest >> testUnsolo [

	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: true.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	performanceRecorder unsolo: #bb.
	self
		assert: performanceRecorder savedPerformance isEmpty
		equals: false.

	self
		assert: performanceRecorder savedPerformance last print
		equals: 'unsolo: #bb.'
]
