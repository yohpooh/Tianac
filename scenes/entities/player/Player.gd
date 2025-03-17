extends CharacterBody2D

#Player Inputs
#Movement Input
var movementInput = Vector2.ZERO
#Jump Input
var jumpInput = false
var jumpInputActuation = false

#Dash Input
var dashInput = false
var canDash = true

#Player Physics
var SPEED = 190.0
var gravityVariable = 0
var tileSize = 32
var MAX_JUMP_HEIGHT = tileSize * 4 + .35
var MIN_JUMP_HEIGHT = tileSize * 2 + .35
#var SPRING_JUMP_HEIGHT = tileSize * 4 + .35
var jumpDuration = 0.3
var springVelocity
var maxJumpVelocity
var minJumpVelocity
var lastDirection = Vector2.RIGHT

#Player States
var currentState = null
var previousState =  null

#Player States
@onready var States = $States

#Player Raycasts
@onready var Raycasts = $Raycasts

func _ready():
	set_velocity_values()
	for state in States.get_children():
		state.Player = self
		state.States = States
	
	previousState = States.playerIdle
	currentState = States.playerIdle
	
func set_velocity_values():
	gravityVariable = 2 * MAX_JUMP_HEIGHT / pow(jumpDuration, 2)
	maxJumpVelocity = -sqrt(2 * gravityVariable * MAX_JUMP_HEIGHT)
	minJumpVelocity = -sqrt(2 * gravityVariable * MIN_JUMP_HEIGHT)
	#springVelocity = -sqrt(2 * gravityVariable * SPRING_JUMP_HEIGHT)
	
func _physics_process(delta):
	player_input()
	change_state(currentState.update(delta))
	move_and_slide()
	$PlayerLabel.text = str("Player: ", currentState.get_name())
	#print("player velocity: ", velocity)
	
func change_state(inputState):
	if inputState != null:
		previousState = currentState
		currentState = inputState
		
		previousState.exit_state()
		currentState.enter_state() 
		

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
		
	#Player Dash Input
	if Input.is_action_just_pressed("Dash"):
		dashInput = true
	else:
		dashInput = false
		
func gravity(delta):
	if !is_on_floor():
		velocity.y += gravityVariable * delta
	pass
	
func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

