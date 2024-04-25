Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'symbol'
	],
	#category : #CoypuRecorderAnnouncement
}

{ #category : #accessing }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : #accessing }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
