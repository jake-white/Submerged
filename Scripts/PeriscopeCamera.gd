extends Camera3D
@export var player : Player
@export var maxRotationSpeed : float
@export var minFOV : float
@export var maxFOV : float
@export var verticalSpeed : float = 1
@export var underwaterEnvironment : Environment
@export var abovewaterEnvironment : Environment
@export var dynamicSkyMat : ProceduralSkyMaterial
@export var topBaseColor : Color
@export var skyColor : Color
@export var submarine : Node3D
@export var surfaceMesh : Node3D
@export var bullet : PackedScene

@export var bulletCount : RichTextLabel

@export var debugText : Label
var rotationSpeed = 0.0
var maxHeight = 52
var surfaceMat
var bullets = 20
var currentFOV

var rampUpRotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	currentFOV = maxFOV
	surfaceMat = surfaceMesh.get_active_material(0).duplicate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotationInput = -player.player_input().x*0.001
	var verticalInput = player.player_input().y
	rotationSpeed = clamp(rotationSpeed + rotationInput, -maxRotationSpeed, maxRotationSpeed)
	if(rotationInput == 0):
		rotationSpeed *= 0.5
	debugText.text = str(rotationSpeed)
	rotate(Vector3.UP, rotationSpeed)
	translate(Vector3(0, verticalInput*verticalSpeed, 0))
	position.x = submarine.position.x
	position.z = submarine.position.z
	position.y = clamp(position.y, submarine.position.y + 2, maxHeight)
	var brightness = clamp(position.y/maxHeight, 0.45, 1)
	dynamicSkyMat.sky_top_color = (skyColor*brightness*2.5)
	dynamicSkyMat.sky_horizon_color = (topBaseColor*brightness)
	dynamicSkyMat.ground_horizon_color = (topBaseColor*brightness)
	surfaceMat.albedo_color = (skyColor*brightness*0.5)
	surfaceMesh.set_surface_override_material(0, surfaceMat)
	# if(position.y > maxHeight-12):
		# dynamicSkyMat.sky_top_color = skyColor*1.05
		# dynamicSkyMat.sky_horizon_color = skyColor*1.05
	underwaterEnvironment.sky.sky_material = dynamicSkyMat
	var density = ((50-clamp(position.y, 0.1, 100))/5000)
	density = clamp(density, 0, 0.05)
	underwaterEnvironment.volumetric_fog_density = density
	environment = underwaterEnvironment
	if(player.get_other_state(0)):
		currentFOV += 1
	elif(player.get_other_state(1)):
		currentFOV -= 1
	currentFOV = clamp(currentFOV, minFOV, maxFOV)
	self.fov = currentFOV

	
	
	if(player.get_corner(2)):
		if(bullets > 0):
			Globals.manager.shake()
			var instance = bullet.instantiate()
			get_node("/root").add_child(instance)
			instance.position = position + transform.basis.z
			instance.rotation = rotation
			bullets-=1
			bulletCount.text = str(bullets)

func pickup():
	bullets+=1
	bulletCount.text = str(bullets)
