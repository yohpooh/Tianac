extends "states.gd"

var lastWallDirection = Vector2.ZERO
var wallPushBack = 40
var wallJumpLock  = false
var manipulatedJump = false

func update(delta):
	if !manipulatedJump:
		player_movement()
	
	jump_movement()
	
	#Down Push Mechanics
	if Input.is_action_pressed("MoveDown"):
		Player.gravity(delta * 4)
	else:
		Player.gravity(delta)
	
	if Player.velocity.y > 0:
		return States.playerFall
	
	if Player.get_next_to_wall() != null:
		pass
	
	if Player.dashInput and Player.canDash:
		return States.playerDash
	
	return null 
	
func jump_movement():
	if wallJumpLock:
		Player.velocity.x = -1 * lastWallDirection.x * Player.SPEED
	pass
	
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
