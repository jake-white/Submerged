extends Node3D
@export var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", die)
	$Area3D.area_entered.connect(on_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= transform.basis.z*5
	pass

func die():
	queue_free()

func on_area_entered(area):
	print(area.name + " hit first...")
	var areaParent = area.get_node("../")
	if(areaParent.is_in_group("Enemy")):
		print(areaParent.name + " found")
		Globals.manager.shake()
		areaParent.die(true)
		die()
