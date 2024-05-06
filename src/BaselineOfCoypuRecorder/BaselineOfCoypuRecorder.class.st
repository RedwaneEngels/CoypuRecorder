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
			package: 'CoypuRecorder-Tests'
			with: [ spec requires: #( 'CoypuRecorder' ) ] ]
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
