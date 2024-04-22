Class {
	#name : #SymbolAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newSymbol'
	],
	#category : #'Announcements-Core-Base'
}

{ #category : #accessing }
SymbolAnnouncement >> newSymbol [
^ newSymbol

]

{ #category : #accessing }
SymbolAnnouncement >> newSymbol: aSymbol [
newSymbol := aSymbol.

]
