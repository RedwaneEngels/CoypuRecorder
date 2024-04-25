Class {
	#name : #BaselineOfCoypuRecorder,
	#superclass : #Object,
	#category : #BaselineOfCoypuRecorder
}

{ #category : #baselines }
BaselineOfCoypuRecorder >> baseline: spec [ 
	<baseline>
	spec
			for: #common
			do:  [ "Packages"
					spec 
							package: 'Coypu';
							package: 'CoypuRecorder';
							package: 'CoypuRecorderTests' with: [ spec requires: #('MyProject');
							baseline: '{BaselineOfCoypu}'
							with: [  spec repository: '{github}://{https://github.com/lucretiomsp/Coypu.git}:{lucretiomsp}/{Coypu}' ] ] ]
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
