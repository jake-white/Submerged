class_name Shark
extends Enemy

@export var eyes : MeshInstance3D
@export var cooldown : Timer
@export var damage : int
var aggro = false
var targetPoint
var moveSpeed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	blinks = true
	super._ready()
	cooldown.connect("timeout", attack)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	targetPoint = Globals.manager.submarine.targetPoint.global_position
	look_at(targetPoint, Vector3.UP)
	if(aggro and not in_range()):
		position -= transform.basis.z*moveSpeed
	pass

func _on_body_entered(body):
	if(body.is_in_group("Submarine")):
		aggro = true

func _on_body_exited(body):
	if(body.is_in_group("Submarine")):
		aggro = false

func in_range():
	var dist = position.distance_to(targetPoint)
	print(dist)
	return dist < 35

func attack():
	if(aggro and in_range()):
		Globals.manager.submarine.take_damage(damage)
