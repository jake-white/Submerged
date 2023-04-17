extends Node3D
@export var type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(global_position.y > Globals.manager.p1cam.global_position.y):
		global_position.y -= delta
	pass

func die():
	queue_free()
