Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'symbol'
	],
	#category : #CoypuRecorder
}

{ #category : #accessing }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : #accessing }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
