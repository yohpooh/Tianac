extends CharacterBody2D

const ACCELERATION = 3000
const MAX_SPEED = 18000
const LIMIT_SPEED_Y = 1200
const JUMP_HEIGHT = 36000
const MIN_JUMP_HEIGHT = 12000
const MAX_COYOTE_TIME = 6
const JUMP_BUFFER_TIME = 10
const WALL_JUMP_AMOUNT = 18000
const WALL_JUMP_TIME = 10
const WALL_SLIDE_FACTOR = 0.8
const WALL_HORIZONTAL_TIME = 30
const GRAVITY = 2100
const DASH_SPEED = 36000

var coyoteTimer = 0
var jumpBufferTimer = 0
var wallJumpTimer = 0
var wallHorizontalTimer = 0
var dashTime = 0

var canJump = false
var friction = false
var wall_sliding = false
var trail = false
var isDashing = false
var hasDashed = false
var isGrabbing = false





"""
# movement adjustable values
var moveSpeed = 300.0
var acceleration = 40
#var friction = 70

# jump adjustale variables
var gravity: float = 55
var jumpBufferTime: int = 10
var cayoteTime: int = 10

var jumpCounter: int = 0
var jumpBufferCounter: int = 0
var cayoteCounter: int = 0

# jump adjustable values
var jumpHeight : float = 150.0
var jumpTimeToPeak : float = 0.3
var jumpTimeToDescent : float = 0.3

	# jump gravity calculations
@onready var jumpVelocity : float = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0
@onready var jumpGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0
@onready var fallGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0

func _physics_process(delta):
	player_gravity(delta)
	player_movement()

func player_movement():
	
	if is_on_floor():
		cayoteCounter = cayoteTime
		jumpCounter = 0
		
	if not is_on_floor():
		if cayoteCounter > 0:
			cayoteCounter -= 1
			
		if jumpBufferCounter > 0 and jumpCounter < 1:
			cayoteCounter = 1
			jumpCounter += 1
			
	if Input.is_action_just_pressed("ui_accept"):
		jumpBufferCounter = jumpBufferTime
		
	if jumpBufferCounter > 0:
		jumpBufferCounter -= 1
	
	if jumpBufferCounter > 0 and cayoteCounter > 0:
		#print("jumpVelocity", jumpVelocity + 200)
		# tentative suggestion if you want to make the second jump to be a little bit smaller add 200 because the jump is -1000 the second jump will be -800
		velocity.y = jumpVelocity
		jumpBufferCounter = 0
		cayoteCounter = 0
		
	# Handle the jump when click the spacebar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#print("jumpVelocity", jumpVelocity)
		velocity.y = jumpVelocity
		#print("Jump Clicked!!")
		
	# Handles the descent of the player
	var horizontal := 0.0
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("right"):
		horizontal += 1.0
		
	velocity.x += horizontal * moveSpeed

	# Get the input direction and handle the movement/deceleration.
	# i added the acceleration for the smoother movement of the character
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x += acceleration
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x -= acceleration
	else:
		#lerp or linear intrepolation to stop the player smoothly
		velocity.x = lerp(velocity.x,0.0,0.2)
		# i added a clamp function for the player to not go beyond the movement speed while walking
	velocity.x = clamp(velocity.x, -moveSpeed, moveSpeed)
	
	move_and_slide()

func player_gravity(delta):
	#print("Jump Gravity: ", jumpGravity, " Fall Gravity: ", jumpVelocity)
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y += jumpGravity * delta
		else:
			velocity.y += fallGravity * delta
	else:
		velocity.y += gravity * delta

# player adjustable variables
var maxSpeed: float = 300.0
var gravity: float = 55
var jumpForce: int = 1100
var acceleration: int = 45
var jumpBufferTime: int = 8
var cayoteTime: int = 8

var jumpCounter: int = 0
var jumpBufferCounter: int = 0
var cayoteCounter: int = 0

func _physics_process(delta):
	player_movement()

func player_gravity(delta):
	pass
	
func player_movement():
	if is_on_floor():
		cayoteCounter = cayoteTime
		jumpCounter = 0
		
	if not is_on_floor():
		if cayoteCounter > 0:
			cayoteCounter -= 1
			
		if jumpBufferCounter > 0 and jumpCounter < 1:
			cayoteCounter = 1
			jumpCounter += 1
	
	velocity.y += gravity
	if velocity.y > 2000:
		velocity.y = 2000
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x += acceleration
	elif  Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x -= acceleration
	else:
		velocity.x = lerp(velocity.x,0.0,0.2)
	
	velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	
	if Input.is_action_just_pressed("ui_select"):
		jumpBufferCounter = jumpBufferTime
	
	if jumpBufferCounter > 0:
		jumpBufferCounter -= 1
	
	if jumpBufferCounter > 0 and cayoteCounter > 0:
		velocity.y = -jumpForce
		jumpBufferCounter = 0
		cayoteCounter = 0
	
	if Input.is_action_just_released("ui_select"):
		if velocity.y < 0:
			velocity.y += 200
		
	move_and_slide()

# Third Logic Attempt with basic movement but different approach with the diffculty

# movement adjustable values
var moveSpeed = 300.0
var acceleration = 50
#var friction = 70

# jump adjustable values
var jumpHeight : float = 100.0
var jumpTimeToPeak : float = 0.5
var jumpTimeToDescent : float = 0.4

	# jump gravity calculations
@onready var jumpVelocity : float = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0
@onready var jumpGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0
@onready var fallGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0
	

func _physics_process(delta):
	player_gravity(delta)
	player_movement()

func player_movement():
	
	# Handle the jump when click the spacebar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
		print("Jump Clicked!!")
		
	# Handles the descent of the player
	var horizontal := 0.0
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("right"):
		horizontal += 1.0
		
	velocity.x += horizontal * moveSpeed
		
	# Get the input direction and handle the movement/deceleration.
	# i added the acceleration for the smoother movement of the character
	if Input.is_action_pressed("ui_right"):
		velocity.x += acceleration
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= acceleration
	else:
		#lerp or linear intrepolation to stop the player smoothly
		velocity.x = lerp(velocity.x,0.0,0.2)
		# i added a clamp function for the player to not go beyond the movement speed while walking
	velocity.x = clamp(velocity.x, -moveSpeed, moveSpeed)
	
	if Input.is_action_just_released("ui_select"):
		if velocity.y < 0:
			velocity.y += 400
	
	move_and_slide()

func player_gravity(delta):
	print("Jump Gravity: ", jumpGravity, " Fall Gravity: ", jumpVelocity)
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y += jumpGravity * delta
		else:
			velocity.y += fallGravity * delta

func add_friction(delta):
	velocity.x -= .02 * delta
	print(velocity)
	#print("SLOW")
		

# Second Logic Attempt with charging jump
@onready var timer: Timer = $Timer
@export var gravity = 700

var timerCount
var bIsJumping
var jumpPower = 0
var jumpMax = -700
var jumpTimeToPeak : float = 1.0
var jumpTimeToDescent : float = 0.4

@onready var jumpVelocity : float = ((2.0 * jumpPower) / jumpTimeToPeak) * -1.0
@onready var jumpGravity : float = ((2.0 * jumpPower) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0
@onready var fallGravity : float = ((2.0 * jumpPower) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0

var speed = 350
var acceleration = 50
var friction = 70

func _physics_process(delta):
	playerGravity(delta)
	playerMovement()
	
func playerMovement():
	velocity.x = get_input_velocity() * speed
	
	var inputDirection: Vector2 = inputDirection()
	if inputDirection() != Vector2.ZERO:
		accelarate(inputDirection)
		#animation walking anims
	else:
		if is_on_floor():
			addFrictiom()
		#idle anims here
	playerJump()
	move_and_slide()
	
func playerGravity(delta):
	if velocity.y < 0.0:
		velocity.y += jumpGravity * delta
	else:
		velocity.y += fallGravity * delta
		
func  playerJump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		timerCount = 0
		jumpPower = 0
		bIsJumping = true
		timer.start()
	elif  Input.is_action_just_released("ui_accept") and is_on_floor():
		bIsJumping = false
		timer.stop()
		if timerCount < 1:
			print("tapped")
			#velocity.y = jumpPower
			velocity.y = jumpVelocity
			#print(timerCount)
		else:
			print("hold for ", timerCount ," second/s")
			velocity.y = jumpPower
	else:
		addFrictiom()
			
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
	else:
		pass
		#if not is_on_floor():
			#velocity.y += gravity
		

func inputDirection() -> Vector2:
	#the vetor2 is zero only in this function 
	var inputDirection = Vector2.ZERO
	inputDirection.x = Input.get_axis("ui_left", "ui_right")
	inputDirection = inputDirection.normalized()
	#print(inputDirection)
	return inputDirection
	
func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("right"):
		horizontal += 1.0
	
	return horizontal
	
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



