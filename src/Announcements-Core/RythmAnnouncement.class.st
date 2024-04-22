Class {
	#name : #RythmAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newRythm'
	],
	#category : #'Announcements-Core-Base'
}

{ #category : #accessing }
RythmAnnouncement >> newRythm [
^ newRythm
]

{ #category : #accessing }
RythmAnnouncement >> newRythm: aRythm [
newRythm := aRythm.
]
