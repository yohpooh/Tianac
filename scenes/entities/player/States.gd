extends Node

@onready var playerIdle = $idle
@onready var playerJump = $jump
@onready var playerMove = $move
@onready var playerFall = $fall
@onready var playerDash = $dash

var Player = null
var States = null

func player_movement():
	Player.velocity.x = Player.movementInput.x * Player.SPEED
	
func exit_state():
	pass
	
func enter_state():
	pass
