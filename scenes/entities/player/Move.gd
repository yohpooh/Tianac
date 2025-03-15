extends "states.gd"

func update(delta):
	player_movement()
	Player.gravity(delta)
	if Player.velocity.y > 0:
		return States.playerFall
	if Player.jumpInputActuation:
		return States.playerJump
	if Player.velocity.x == 0:
		return States.playerIdle
	if Player.dashInput and Player.canDash:
		return States.playerDash
	return null

func enter_state():
	Player.canDash = true
