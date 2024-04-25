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
			for: #common
			do:  [ "Packages"
					spec 
							package: 'CoypuRecorder';
							package: 'CoypuRecorderTests' with: [ spec requires: #('CoypuRecorder');
							baseline: '{BaselineOfCoypu}'
							with: [  spec repository: '{github}://{https://github.com/lucretiomsp/Coypu.git}:{lucretiomsp}/{Coypu}' ] ] ]
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
