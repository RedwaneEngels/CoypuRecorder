Class {
	#name : #DirtNotesAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newDirtNotes',
		'asDirtNotes'
	],
	#category : #'Announcements-Core-Base'
}

{ #category : #accessing }
DirtNotesAnnouncement >> asDirtNotes [

^asDirtNotes.
]

{ #category : #accessing }
DirtNotesAnnouncement >> asDirtNotes: boolean [

asDirtNotes := boolean.
]

{ #category : #accessing }
DirtNotesAnnouncement >> boolean [

^boolean.
]

{ #category : #accessing }
DirtNotesAnnouncement >> newDirtNotes [

^newDirtNotes 

]

{ #category : #accessing }
DirtNotesAnnouncement >> newDirtNotes: aNumberInString [

newDirtNotes := aNumberInString.

]
