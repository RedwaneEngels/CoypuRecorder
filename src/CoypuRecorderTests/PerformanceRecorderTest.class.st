Class {
	#name : #PerformanceRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder'
	],
	#category : #CoypuRecorderTests
}

{ #category : #tests }
PerformanceRecorderTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : #running }
PerformanceRecorderTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt  new
]

{ #category : #tests }
PerformanceRecorderTest >> test [
  | api |
  api := PerformanceRecorder selectors. "ici on pourra filtrer"
   Performance selectors do: [
    :s | 
      self assert: (api includes: s) ]
]

{ #category : #tests }
PerformanceRecorderTest >> testFreq [

	self assertEmpty: self commands.

	performanceRecorder freq: 138 bpm.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'freq: 138 bpm.'
]

{ #category : #tests }
PerformanceRecorderTest >> testMute [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'mute: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlay [

	self assert: self commands isEmpty equals: true.

	performanceRecorder play.

	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'play.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlayFor [

	self assert: self commands isEmpty equals: true.

	performanceRecorder playFor: 12 bars.

	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'playFor: 12 bars.'
]

{ #category : #tests }
PerformanceRecorderTest >> testRestore [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	performanceRecorder restore.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'restore.'
]

{ #category : #tests }
PerformanceRecorderTest >> testSolo [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'solo: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testStop [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.
	performanceRecorder stop.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'stop.'
]

{ #category : #tests }
PerformanceRecorderTest >> testUnsolo [

	self assert: self commands isEmpty equals: true.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	performanceRecorder unsolo: #bb.
	self assert: self commands isEmpty equals: false.

	self assert: self commands last print equals: 'unsolo: #bb.'
]
