Class {
	#name : 'PerformanceReplayerTest',
	#superclass : 'TestCase',
	#instVars : [
		'performanceRecorder',
		'replayer',
		'securePerformance'
	],
	#category : 'CoypuRecorder-Tests-Tests',
	#package : 'CoypuRecorder-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PerformanceReplayerTest >> filePath [

	| x |
	x := FileLocator home / 'Documents'.
	x := x / 'PerformanceScripts'
	     /
	     (DateAndTime now asDate ddmmyyyy asString
		      copyReplaceAll: '/'
		      with: '-').
	^ x
]

{ #category : 'running' }
PerformanceReplayerTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	Performance uniqueInstance performanceType: PerfTypeMock new.
	performanceRecorder performer: PerformerSuperDirt new.
	replayer := PerformanceMusicalReplayer new.
	securePerformance := SavedPerformance new.
	securePerformance
		add: (RecordedInstructionCommand new instruction:
					 'performer:  PerformerSuperDirt new.');
		add: (RecordedInstructionCommand new instruction: 'freq: 138 bpm.');
		add: (RecordedInstrumentCommand new
				 rhythm: '16 upbeats';
				 symbol: 'bd');
		add:
		(RecordedInstructionCommand new instruction: 'playFor: 16 bars.')
]

{ #category : 'running' }
PerformanceReplayerTest >> tearDown [

	Performance uniqueInstance performanceType: PerfType new.
	super tearDown
]

{ #category : 'tests' }
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
	self denyEmpty: oldPerformanceScript.

	replayer readScriptFromStonFile: x / 'ReplayablePerformanceTest.ston'.

	replayer performanceScript
		with: oldPerformanceScript
		do: [ :w :y | self assert: w equals: y ] ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') delete ]
]

{ #category : 'tests' }
PerformanceReplayerTest >> testReadScriptStonFileWithSureSavedPerformance [

	| x oldPerformanceScript |
	x := self filePath.



	replayer getScript: securePerformance.

	[
	replayer writeScriptInStonFile: 'ReplayablePerformanceTest'.
	oldPerformanceScript := replayer performanceScript.


	replayer readScriptFromStonFile: x / 'ReplayablePerformanceTest.ston'.

	replayer performanceScript
		with: oldPerformanceScript
		do: [ :w :y | self assert: w equals: y ] ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') delete ]
]

{ #category : 'tests' }
PerformanceReplayerTest >> testReplaySameAsOriginal [

	| performance replayedPerformance |
	performanceRecorder freq: 138 bpm.
	(Delay forMilliseconds: 500) wait.
	16 upbeats to: #bass1.
	(Delay forMilliseconds: 1000) wait.
	16 downbeats
		to: #bass3;
		dirtNotes: '4'.

	replayer getScript: performanceRecorder savedPerformance.

	performance := replayer performanceScript.
	self denyEmpty: performance.
	replayer replayWithoutPlayground.
	replayer performanceScript: nil.
	replayer getScript: performanceRecorder savedPerformance.
	replayedPerformance := replayer performanceScript.
	performance
		with: replayedPerformance
		do: [ :perf1 :perf2 | self assert: perf1 equals: perf2 ]
]

{ #category : 'tests' }
PerformanceReplayerTest >> testReplaySameAsOriginalWithSureSavedPerformance [

	| performance replayedPerformance |
	replayer getScript: securePerformance.

	performance := replayer performanceScript.

	replayer replayWithoutPlayground.
	(Delay forMilliseconds: 10) wait.
	replayer getScript: performanceRecorder savedPerformance.
	
	replayedPerformance := replayer performanceScript.
	performance
		with: replayedPerformance
		do: [ :perf1 :perf2 | self assert: perf1 equals: perf2 ]
]

{ #category : 'tests' }
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
		(x / 'ReplayablePerformanceTest.ston') delete ]
]

{ #category : 'tests' }
PerformanceReplayerTest >> testWriteScriptStonFileWhenNameIsTaken [

	| x |
	x := self filePath.
	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
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

	[  ] ensure: [
		(x / 'ReplayablePerformanceTest.ston') delete.
		(x / 'ReplayablePerformanceTest.1.ston') delete ]
]
