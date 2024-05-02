Extension { #name : #Sequencer }

{ #category : #'*CoypuRecorder' }
Sequencer >> to: aSymbol atTime: aTime [
	" assign sequencer to the performance at aSymbol. if a sound for SuperDirt is not specified, the symbol is used for sound name"

	(Delay forSeconds: aTime) wait.
	self to: aSymbol
]
