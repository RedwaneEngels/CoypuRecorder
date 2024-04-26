Extension { #name : #String }

{ #category : #'*CoypuRecorder' }
String >> suffixeNumber [

	| suffixe |
	suffixe := 'th'.
	self last asString = '3' ifTrue: [ suffixe := 'rd' ].
	^ suffixe
]
