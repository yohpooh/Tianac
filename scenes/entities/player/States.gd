extends Node

@onready var playerIdle = $idle
@onready var playerJump = $jump
@onready var playerMove = $move
@onready var playerFall = $fall
@onready var playerDash = $dash

var Player = null
var States = null

func player_movement():
	if Player.movementInput.x != 0:
		Player.velocity.x = Player.movementInput.x * Player.SPEED
		if Player.velocity.x > 200:
			Player.velocity.x = 200
		elif Player.velocity.x < -200:
			Player.velocity.x = -200
		
		if Player.movementInput.x > 0:
			Player.lastDirection = Vector2.RIGHT
		elif Player.movementInput.x < 0:
			Player.lastDirection = Vector2.LEFT
	else:
		Player.velocity.x = move_toward(Player.velocity.x, .0, Player.SPEED)
	
	
func exit_state():
	pass
	
func enter_state():
	pass
