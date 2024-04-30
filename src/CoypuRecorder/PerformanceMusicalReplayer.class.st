Class {
	#name : #PerformanceMusicalReplayer,
	#superclass : #PerformanceReplayer,
	#type : #variable,
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #visiting }
PerformanceMusicalReplayer >> getScript: aSavedPerformance [

	aSavedPerformance scriptWithDelayTimeForReplayer: self
]

{ #category : #accessing }
PerformanceMusicalReplayer >> performanceScript: anOrderedCollection [

	performanceScript := anOrderedCollection
]

{ #category : #writing }
PerformanceMusicalReplayer >> writeScriptInStonFile [

	self writeScriptInStonFile: 'ReplayablePerformance'
]

{ #category : #writing }
PerformanceMusicalReplayer >> writeScriptInTxtFile [

	self writeScriptInTxtFile: 'ReplayablePerformance'
]
