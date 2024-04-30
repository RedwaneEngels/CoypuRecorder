Class {
	#name : #PerformanceReplayer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'performanceScript'
	],
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #visiting }
PerformanceReplayer >> getScriptWithDelayTime: aSavedPerformance [

	aSavedPerformance scriptWithDelayTimeForReplayer: self
]

{ #category : #accessing }
PerformanceReplayer >> performanceScript: anOrderedCollection [

	performanceScript := anOrderedCollection
]

{ #category : #accessing }
PerformanceReplayer >> replay [

	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"
	
'.
	content := content , String cr.
	content := content , ('' join: performanceScript).
	^ StPlayground openContents: content
]
