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
	spec
		for: #common do: [ "External dependencies"
			spec
				package: 'OSC'
				with: [ spec repository: 'github://Ducasse/OSC/src' ];
				baseline: 'Toplo'
				with: [
					spec repository: 'github://pharo-graphics/Toplo:master/src' ].
			"Packages"
			spec
				package: 'Coypu' with: [ spec requires: #( 'OSC' ) ];
				package: 'CoypuRecorder' with: [ spec requires: #( 'Coypu' ) ];
				package: 'CoypuRecorder-Tests'
				with: [ spec requires: #( 'CoypuRecorder' ) ] ];
		package: 'CoypuRecorder_Graphics'
		with: [ spec requires: #( 'Toplo';'CoypuRecorder' ) ].
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
