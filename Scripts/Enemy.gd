class_name Enemy
extends Node3D

@export var explosion : PackedScene
@export var enemyPoint : PackedScene
@export var pickup : PackedScene
@export var blinks : bool
var myPoint
var radar_obj


# Called when the node enters the scene tree for the first time.
func _ready():
	radar_obj = get_node("/root/Scene/Submarine/Radar")
	init_radar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die(drop_pickup):
	var instance = explosion.instantiate()
	instance.position = position
	get_node("/root").add_child(instance)
	if(drop_pickup):
		var pickupInstance = pickup.instantiate()
		pickupInstance.position = position
		get_node("/root").add_child(pickupInstance)
	myPoint.queue_free()
	queue_free()

func init_radar():
	myPoint = enemyPoint.instantiate()
	myPoint.get_node("AnimationPlayer").play("blink" if blinks else "static")
	radar_obj.init_point(myPoint)
	radar_obj.timer.connect("timeout", update_radar)
	update_radar()

func update_radar():
	radar_obj.update_point(myPoint, position)
