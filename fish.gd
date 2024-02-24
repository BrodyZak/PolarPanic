extends Area3D

@export var stream: AudioStream
@onready var audioPlayer = $AudioStreamPlayer
const ROTATION_SPEED = 2 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(ROTATION_SPEED))

func _on_body_entered(body):
	Global.score += 1
	audioPlayer.play()
	await audioPlayer.finished
	queue_free() # delete self 
