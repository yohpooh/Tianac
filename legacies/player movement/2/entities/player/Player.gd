extends CharacterBody2D

#Player Inputs
#Movement Input
var movementInput = Vector2.ZERO
#Jump Input
var jumpInput = false
var jumpInputActuation = false
#CLimb Input
var climbInput = false
#Dash Input
var dashInput = false
#Player Physics
var SPEED = 180.0
var gravityVariable = 0
var tileSize = 32
var MAX_JUMP_HEIGHT = tileSize * 3 + .35
var MIN_JUMP_HEIGHT = tileSize * 2 + .35
var jumpDuration = 0.3
var springVelocity
var maxJumpVelocity
var minJumpVelocity

#Player States
var currentState = null
var previousState =  null

#Player State
@onready var States = $States

#Player Raycasts
@onready var RaycastNode = $Raycasts
@onready var RaycastRightTop = $Raycasts/RightTop
@onready var RaycastRightBottom = $Raycasts/RightBottom
@onready var RaycastLeftTop = $Raycasts/LeftTop
@onready var RaycastLeftBottom = $Raycasts/LeftBottom

func _ready():
	setVelocityValues()
	for state in States.get_children():
		state.Player = self
		state.States = States
	
	previousState = States.playerIdle
	currentState = States.playerIdle
	
func setVelocityValues():
	gravityVariable = 2 * MAX_JUMP_HEIGHT / pow(jumpDuration, 2)
	maxJumpVelocity = -sqrt(2 * gravityVariable * MAX_JUMP_HEIGHT)
	minJumpVelocity = -sqrt(2 * gravityVariable * MIN_JUMP_HEIGHT)
	#springVelocity = -sqrt(2 * gravityVariable * SPRING_JUMP_HEIGHT)
	
func _physics_process(delta):
	player_input()
	changeState(currentState.update(delta))
	move_and_slide()
	$Label.text = str("Current State: " + currentState.get_name())
	
func changeState(inputState):
	if inputState != null:
		previousState = currentState
		currentState = inputState
		
		previousState.exit_state()
		currentState.enter_state() 
		
func get_next_to_wall():
	for raycast in RaycastNode.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
				
	return null
	"""
	#Right Side
	RaycastRightTop.force_raycast_update()
	if RaycastRightTop.is_colliding():
		return Vector2.RIGHT
	RaycastRightBottom.force_raycast_update()
	if RaycastRightBottom.is_colliding():
		return Vector2.RIGHT
		
	#Left Side
	RaycastLeftTop.force_raycast_update()
	if RaycastLeftTop.is_colliding():
		return Vector2.LEFT
	RaycastLeftBottom.force_raycast_update()
	if RaycastLeftBottom.is_colliding():
		return Vector2.LEFT
	"""

func player_input():
	movementInput = Vector2.ZERO
	
	#Player Movement Input
	if Input.is_action_pressed("MoveRight"):
		movementInput.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movementInput.x -= 1

	if Input.is_action_pressed("MoveUp"):
		movementInput.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movementInput.y += 1

	#Player Jump Input
	if Input.is_action_just_pressed("Jump"):
		jumpInputActuation = true
	else:
		jumpInputActuation = false
		
	if Input.is_action_pressed("Jump"):
		jumpInput = true
	else:
		jumpInput = false
		
	#Player Climb Input
	if Input.is_action_pressed("Climb"):
		climbInput = true
	else:
		climbInput = false
		
	#Player Dash Input
	if Input.is_action_pressed("Dash"):
		dashInput = true
	else:
		dashInput = false
		
func gravity(delta):
	if !is_on_floor():
		velocity.y += gravityVariable * delta
	pass
	
