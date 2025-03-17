extends "states.gd"

var lastWallDirection = Vector2.ZERO
@export var slideFriction = .5

func update(delta):
	slide_movement(delta)
	if Player.get_next_to_wall() == null:
		return States.playerFall
		
	if Player.jumpInputActuation:
		return States.playerJump
		
	if Player.is_on_floor():
		return States.playerIdle
	
#	if Player.dashInput and Player.canDash:
#		return States.playerDash
	
	return null

func slide_movement(delta):
	player_movement()
	Player.gravity(delta)
	Player.velocity.y *= slideFriction

func enter_state():
	lastWallDirection = Player.get_next_to_wall()

func exit_state():
	pass
	
