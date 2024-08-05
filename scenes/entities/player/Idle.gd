extends "state.gd"

func update(delta):
	player_movement()
	Player.gravity(delta)
	if Player.velocity.y > 0:
		return States.playerFall
	if Player.jumpInputActuation:
		return States.playerJump
	if Player.movementInput.x != 0:
		return States.playerMove
		
	if Player.jumpInputActuation == true:
		return States.playerJump
	return null
