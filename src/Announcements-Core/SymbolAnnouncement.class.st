Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'symbol'
	],
	#category : #'Announcements-Core-Base'
}

{ #category : #accessing }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : #accessing }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
