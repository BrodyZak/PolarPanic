extends CharacterBody3D


const SPEED = 3.5
const JUMP_VELOCITY = 5
var jumps = 0
@onready var pivot = $camOrigin
@onready var audioPlayer = $AudioStreamPlayer
@export var sensitivity = 0.25



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))

func _physics_process(delta):
	# gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if is_on_floor(): 
		jumps = 0
		
	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if jumps == 0:
			velocity.y = JUMP_VELOCITY
			jumps = 1  
		
	# double jump
	if Input.is_action_just_pressed("jump") and !is_on_floor():
		if jumps == 1:
			velocity.y = JUMP_VELOCITY
			jumps = 2
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		audioPlayer.play()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
