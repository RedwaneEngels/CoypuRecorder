Class {
	#name : #PerformanceReplayerTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder',
		'replayer'
	],
	#category : #'CoypuRecorderTest-Tests'
}

{ #category : #tests }
PerformanceReplayerTest >> filePath [

	| x |
	x := FileLocator home / 'Documents'.
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	^ x
]

{ #category : #running }
PerformanceReplayerTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt new.
		replayer := PerformanceMusicalReplayer new. 

]

{ #category : #tests }
PerformanceReplayerTest >> testReadScriptStonFile [

	| x oldPerformanceScript |
	x := self filePath.
	
	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.

	replayer getScript: performanceRecorder savedPerformance.

	[
	replayer writeScriptInStonFile: 'ReplayablePerformanceTest'.
	oldPerformanceScript := replayer performanceScript.


	replayer readScriptFromStonFile: x / 'ReplayablePerformanceTest.ston'.

	replayer performanceScript
		with: oldPerformanceScript
		do: [ :w :y | self assert: w equals: y ] ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') ensureDelete ]
]

{ #category : #tests }
PerformanceReplayerTest >> testWriteScriptStonFile [

	| x oldPerformanceScript stream |
	x := self filePath.
	self
		assert: (x / 'ReplayablePerformanceTest.ston') isFile
		equals: false.

	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.

	replayer getScript: performanceRecorder savedPerformance.

	[
	replayer writeScriptInStonFile: 'ReplayablePerformanceTest'.
	oldPerformanceScript := replayer performanceScript.
	stream := (x / 'ReplayablePerformanceTest.ston') asFileReference
		          readStream.
	replayer performanceScript: (STON fromStream: stream).

	replayer performanceScript
		with: oldPerformanceScript
		do: [ :w :y | self assert: w equals: y ] ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') ensureDelete ]
]

{ #category : #tests }
PerformanceReplayerTest >> testWriteScriptStonFileWhenNameIsTaken [

	| x |
	x := self filePath.
	16 upbeats to: #bd.
	replayer getScript: performanceRecorder savedPerformance.
	replayer writeScriptInStonFile: 'ReplayablePerformanceTest'.
	self
		assert: (x / 'ReplayablePerformanceTest.ston') isFile
		equals: true.
	self
		assert: (x / 'ReplayablePerformanceTest1.ston') isFile
		equals: false.
	replayer writeScriptInStonFile: 'ReplayablePerformanceTest'.
	self
		assert: (x / 'ReplayablePerformanceTest.ston') isFile
		equals: true.
	self
		assert: (x / 'ReplayablePerformanceTest.1.ston') isFile
		equals: true.
	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	replayer getScript: performanceRecorder savedPerformance.
	[  ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') ensureDelete.
		(x / 'ReplayablePerformanceTest.1.ston') ensureDelete ]
]
