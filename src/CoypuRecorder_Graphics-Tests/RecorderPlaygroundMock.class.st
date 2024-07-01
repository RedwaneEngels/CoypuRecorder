Class {
	#name : 'RecorderPlaygroundMock',
	#superclass : 'RecorderPlayground',
	#instVars : [
		'lastButtonPressed'
	],
	#category : 'CoypuRecorder_Graphics-Tests',
	#package : 'CoypuRecorder_Graphics-Tests'
}

{ #category : 'accessing' }
RecorderPlaygroundMock >> lastButtonPressed [

^lastButtonPressed 
	
]

{ #category : 'playing' }
RecorderPlaygroundMock >> load [

	lastButtonPressed := 'load'
]

{ #category : 'playing' }
RecorderPlaygroundMock >> play [

lastButtonPressed := 'play'


]

{ #category : 'playing' }
RecorderPlaygroundMock >> save [

	lastButtonPressed := 'save'
]

{ #category : 'playing' }
RecorderPlaygroundMock >> stop [

	lastButtonPressed := 'stop'
]
