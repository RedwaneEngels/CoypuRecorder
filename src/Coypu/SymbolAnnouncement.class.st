Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'symbol'
	],
	#category : #Coypu
}

{ #category : #accessing }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : #accessing }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
