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
							package: 'Coypu' with:  [ spec repository: 'github://lucretiomsp/Coypu/src' ];
							package: 'CoypuRecorder';
							package: 'CoypuRecorderTests' with: [ spec requires: #('CoypuRecorder')]]
							
]

{ #category : #accessing }
BaselineOfCoypuRecorder >> projectClass [ 
^ MetacelloCypressBaselineProject 

]
