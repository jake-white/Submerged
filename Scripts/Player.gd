class_name Player
extends Node3D
@export var actionIndex : int
@export var joypadIndex : int
var myInput

# Called when the node enters the scene tree for the first time.
func _ready():
	myInput = DDRInput.new(actionIndex, joypadIndex)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_input():
	return myInput.GetVector()

func middle():
	return myInput.GetMiddle()

func get_corner(index):
	return myInput.GetCorner(index)

func get_other_state(index):
	return myInput.GetOtherState(index)
