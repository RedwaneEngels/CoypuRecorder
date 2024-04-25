Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'symbol'
	],
	#category : #CoypuRecorderAnnouncements
}

{ #category : #accessing }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : #accessing }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
