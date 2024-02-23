extends CharacterBody2D

const speed = 400
const jumpPower = -1800

const acceleration = 50
const friction = 70

const gravity = 120

const maxJumps = 2
var currentJumps = 1

func _physics_process(delta):
	#only in this script
	var inputDirection: Vector2 = inputDirection()
	
	if inputDirection() != Vector2.ZERO:
		accelarate(inputDirection)
		#animation walking anims
	else:
		addFrictiom()
		#idle anims here
	playerMovement()
	jump()
	
func inputDirection() -> Vector2:
	#onlu in this function
	var inputDirection = Vector2.ZERO
	
	inputDirection.x = Input.get_axis("ui_left", "ui_right")
	inputDirection = inputDirection.normalized()
	return inputDirection
	
func accelarate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)
	
func addFrictiom():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
func jump():
	if Input.is_action_just_pressed("ui_accept"):
		if currentJumps < maxJumps:
			velocity.y = jumpPower
			currentJumps = currentJumps + 1
	else:
		velocity.y += gravity
		
	if is_on_floor():
		currentJumps = 1
	
func playerMovement():
	move_and_slide()
