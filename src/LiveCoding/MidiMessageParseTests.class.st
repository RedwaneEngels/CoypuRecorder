Class {
	#name : 'MidiMessageParseTests',
	#superclass : 'TestCase',
	#category : 'LiveCoding-Tests',
	#package : 'LiveCoding',
	#tag : 'Tests'
}

{ #category : 'tests' }
MidiMessageParseTests >> testIsVoiceMessage [

self assert: 16r90 isVoiceMessage equals: true
]
