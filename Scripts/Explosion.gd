extends GPUParticles3D

@export var main : GPUParticles3D
@export var eject : GPUParticles3D
@export var spikes : GPUParticles3D
var started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	explode()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(started):
		if(!main.emitting and !eject.emitting and !spikes.emitting):
			die()
	pass

func explode():
	main.emitting = true
	eject.emitting = true
	spikes.emitting = true
	started = true


func die():
	queue_free()
