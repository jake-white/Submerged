class_name GameManager
extends Node3D
@export var shaker : Shake
@export var p1cam : Camera3D
@export var p2cam : Camera3D
@export var p1 : Player
@export var p2 : Player
@export var submarine : Submarine

@export var gameover1 : Node
@export var gameover2 : Node

var gameover = false

func _init():
	Globals.manager = self
	

func _ready():
	pass

func shake():
	shaker.start_one_shot(0.5, 0.5)
	
func _process(delta):
	p1cam.h_offset = shaker.offset.x
	p1cam.v_offset = shaker.offset.y	
	p2cam.h_offset = shaker.offset.x
	p2cam.v_offset = shaker.offset.y
	if(gameover and (p1.middle() or p2.middle())):
		gameover = false
		get_tree().reload_current_scene()

func game_over():
	gameover = true
	gameover1.visible = true
	gameover2.visible = true
