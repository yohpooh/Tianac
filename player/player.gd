extends CharacterBody2D

@onready var timer: Timer = $Timer
@export var gravity = 500

var timerCount
var bIsJumping
var jumpPower
var jumpMax = -550


var speed = 350
var acceleration = 50
var friction = 70

func _physics_process(delta):
	playerGravity(delta)
	playerMovement()
	
func playerMovement():
	
	var inputDirection: Vector2 = inputDirection()
	if inputDirection() != Vector2.ZERO:
		accelarate(inputDirection)
		#animation walking anims
	else:
		pass
		#addFrictiom()
		#idle anims here
	playerJump()
	move_and_slide()
	
func playerGravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func  playerJump():
	if Input.is_action_just_pressed("ui_accept"):
		timerCount = 0
		jumpPower = 0
		bIsJumping = true
		timer.start()
	if  Input.is_action_just_released("ui_accept"):
		bIsJumping = false
		timer.stop()
		if timerCount < 1:
			print("tapped")
			velocity.y = jumpPower
			#print(timerCount)
		else:
			print("hold for ", timerCount ," second/s")
			velocity.y = jumpPower
			
	if bIsJumping:
		if timerCount < 3:
			jumpPower -= 10
			if jumpPower > jumpMax:
				jumpPower -= 15
			elif jumpPower <= jumpMax:
				jumpPower = jumpMax
			print("jumpPower::if " , jumpPower)
		elif timerCount >= 3:
			jumpPower = jumpMax
			print("jumpPower::else " , jumpPower)
		"""
		else:
			jumpPower = jumpMax
			print("jumpPower::else " , jumpPower)
		"""
	else:
		pass
		

func inputDirection() -> Vector2:
	#the vetor2 is zero only in this function 
	var inputDirection = Vector2.ZERO
	inputDirection.x = Input.get_axis("ui_left", "ui_right")
	inputDirection = inputDirection.normalized()
	return inputDirection
	
func accelarate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)
	
func addFrictiom():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
			
func timerTimeOut():
	timerCount += 1
	print("charging")
	print(timerCount)
	#queue_free()

"""
const speed = 350
const jumpPower = -2500

const acceleration = 50
const friction = 70

const gravity = 150

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
"""



