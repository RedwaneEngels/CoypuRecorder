Class {
	#name : #PerformanceTextualReplayer,
	#superclass : #PerformanceReplayer,
	#type : #variable,
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #visiting }
PerformanceTextualReplayer >> getScript: aSavedPerformance [

	aSavedPerformance scriptForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithRelativeTime: aSavedPerformance [

	aSavedPerformance scriptWithRelativeTimeForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithTime: aSavedPerformance [

	aSavedPerformance scriptWithTimeForReplayer: self
]

{ #category : #accessing }
PerformanceTextualReplayer >> writeScriptInStonFile [

self writeScriptInStonFile: 'TextualPerformance'
]

{ #category : #accessing }
PerformanceTextualReplayer >> writeScriptInTxtFile [

	self writeScriptInTxtFile: 'TextualPerformance'
]
