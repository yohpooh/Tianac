extends "state.gd"

func update(delta):
	player_movement()
	Player.gravity(delta)
	
	if Player.velocity.y > 0:
		return States.playerFall
	if Player.get_next_to_wall() != Vector2.ZERO:
		return States.playerSlide
	return null 
	
func enter_state():
	if Player.previousState == States.playerSlide:
		Player.velocity.x += -1 * States.playerSlide.lastWallDirection 
	Player.velocity.y = Player.maxJumpVelocity
