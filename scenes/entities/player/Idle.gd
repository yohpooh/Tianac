extends "states.gd"

func update(delta):
	player_movement()
	Player.gravity(delta)
	if Player.movementInput.x != 0:
		return States.playerMove
		
	if Player.velocity.y > 0:
		return States.playerFall
		
	if Player.jumpInputActuation:
		return States.playerJump
		
	if Player.jumpInputActuation == true:
		return States.playerJump
		
	if Player.dashInput and Player.canDash:
		return States.playerDash
	return null
	
func enter_state():
	Player.canDash = true
