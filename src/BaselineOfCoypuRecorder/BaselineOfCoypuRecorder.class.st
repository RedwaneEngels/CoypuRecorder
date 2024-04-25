Class {
	#name : #BaselineOfCoypuRecorder,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoypuRecorder
}

{ #category : #accessing }
BaselineOfCoypuRecorder >> CoypuRecorder [ 
^ MetacelloCypressBaselineProject 

]

{ #category : #baselines }
BaselineOfCoypuRecorder >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'Coypu';
			package: 'CoypuRecorder' with: [ spec requires: #( 'Coypu' ) ];
			package: 'CoypuRecorderTests'
			with: [ spec requires: #( 'CoypuRecorder' ) ] ];
			package: 'CoypuRecorderAnnouncements'
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
