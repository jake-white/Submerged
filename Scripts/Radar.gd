class_name Radar
extends Node3D

@export var rotatePlane : Node3D
@export var timer : Timer
@export var hpBar : Node3D
@export var hpGradient : Gradient
@export var hpMesh : MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# look_at(Globals.manager.p1cam.position, Vector3.UP)
	rotatePlane.rotation.z = -get_node("..").rotation.y
	pass

func init_point(point):
	rotatePlane.add_child(point)

func update_point(point, enemyPosition):
	var relative = global_position - enemyPosition
	relative*=0.05
	if(relative.length() < 4):
		point.position = Vector3(-relative.x, relative.z, 0)
		point.visible = true
	else:
		point.position = position
		point.visible = false
	
func update_stats(hp_percent):
	hpBar.scale.y = hp_percent
	var mat = hpMesh.get_active_material(0)
	mat.albedo_color = hpGradient.sample(1-hp_percent)
	hpMesh.set_surface_override_material(0, mat)
