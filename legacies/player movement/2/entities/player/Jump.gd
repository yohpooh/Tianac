extends "state.gd"

var lastWallDirection = Vector2.ZERO
var wallJumpLock  = false
var manipulatedJump = false

func update(delta):
	if !manipulatedJump:
		player_movement()
	
	jump_movement()
	Player.gravity(delta)
	
	if Player.velocity.y > 0:
		return States.playerFall
#	if Player.get_next_to_wall() != null:
#		return States.playerSlide
	return null 
	
func jump_movement():
	if wallJumpLock:
		Player.velocity.x = -1 * lastWallDirection.x * Player.SPEED
	
func enter_state():
	if Player.previousState == States.playerSlide:
		manipulatedJump = true
		wallJumpLock = true
		lastWallDirection = States.playerSlide.lastWallDirection
	Player.velocity.y += Player.maxJumpVelocity
		
func exit_state():
	wallJumpLock = false
	manipulatedJump = false
	lastWallDirection = Vector2.ZERO
