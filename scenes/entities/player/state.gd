extends Node

var Player = null
var States = null

func player_movement():
	Player.velocity.x = Player.movementInput.x * Player.SPEED
	
func exit_state():
	pass
	
func enter_state():
	pass
