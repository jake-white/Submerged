extends Node3D

@export var toFollow : Node3D
@export var followY : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y = position.y
	position = toFollow.position
	rotation = toFollow.rotation
	position.y = y
