extends "state.gd"

func update(delta):
	player_movement()
	Player.gravity(delta)
	if Player.velocity.y > 0:
		return States.playerFall
	if Player.jumpInputActuation:
		return States.playerJump
	if Player.velocity.x == 0:
		return States.playerIdle
	return null
	
func player_movement():
	pass
	Player.velocity.x = Player.movementInput.x * Player.SPEED
