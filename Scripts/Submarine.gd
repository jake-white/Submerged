class_name Submarine
extends RigidBody3D
@export var player : Player
@export var litMaterial : Material
@export var unlitMaterial : Material
@export var upBox : MeshInstance3D
@export var downBox : MeshInstance3D
@export var leftBox : MeshInstance3D
@export var rightBox : MeshInstance3D
@export var middleBox : MeshInstance3D
@export var upleftBox : MeshInstance3D
@export var uprightBox : MeshInstance3D
@export var downleftBox : MeshInstance3D
@export var downrightBox : MeshInstance3D
@export var radar : Radar
@export var moveSpeed = 2
@export var turnSpeed = 3

@export var damageCooldown : Timer
@export var targetPoint : Node3D

var maxhp = 100
var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var forwardInput = -player.player_input().y
	var turningInput = -player.player_input().x
	apply_force(transform.basis.z*forwardInput*moveSpeed, $CollisionShape3D.position)
	apply_torque(transform.basis.y*turningInput*turnSpeed)
	handle_ddr_vis()
	pass

func handle_ddr_vis():
	upBox.set_surface_override_material(0, litMaterial if player.player_input().y > 0 else unlitMaterial)
	downBox.set_surface_override_material(0, litMaterial if player.player_input().y < 0 else unlitMaterial)
	leftBox.set_surface_override_material(0, litMaterial if player.player_input().x < 0 else unlitMaterial)
	rightBox.set_surface_override_material(0, litMaterial if player.player_input().x > 0 else unlitMaterial)
	upleftBox.set_surface_override_material(0, litMaterial if player.get_other_state(0) else unlitMaterial)
	uprightBox.set_surface_override_material(0, litMaterial if player.get_other_state(1) else unlitMaterial)
	downleftBox.set_surface_override_material(0, litMaterial if player.get_other_state(2) else unlitMaterial)
	downrightBox.set_surface_override_material(0, litMaterial if player.get_other_state(3) else unlitMaterial)
	middleBox.set_surface_override_material(0, litMaterial if player.get_other_state(4) else unlitMaterial)

func take_damage(amount):
	if(damageCooldown.is_stopped()):
		damageCooldown.start()
		Globals.manager.shake()
		hp -= amount
		hp = clamp(hp, 0, maxhp)
		radar.update_stats((hp as float)/(maxhp as float))
	if(hp <= 0):
		Globals.manager.game_over()

func on_area_entered(area):
	var areaParent = area.get_node("../")
	if(areaParent.is_in_group("Pickup")):
		areaParent.die()

func on_body_entered(body):
	print(body.name + " hit first...")
	if(body.is_in_group("Wall")):
		print("WALL")
		take_damage(5)
	elif(body.is_in_group("Mine")):
		print("MINE")
		take_damage(5)
		body.get_node("../").die(false)
		Globals.manager.p2cam.pickup()
