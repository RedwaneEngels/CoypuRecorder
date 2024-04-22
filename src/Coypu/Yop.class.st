Class {
	#name : #Yop,
	#superclass : #Object,
	#instVars : [
		'rythmList',
		'counter'
	],
	#category : #Coypu
}

{ #category : #'as yet unclassified' }
Yop >> rythmAdded: aRythm [

rythmList ifNil:[ rythmList = Array new: 40.
						counter := 1  ].

rythmList add: aRythm 


]
