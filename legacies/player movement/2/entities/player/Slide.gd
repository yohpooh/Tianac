extends "state.gd"

var lastWallDirection = Vector2.ZERO
@export var slideFriction = .8
func update(delta):
	player_movement()
	Player.gravity(delta)
	friction()
	if Player.jumpInputActuation == true:
		return States.playerJump
	if Player.get_next_to_wall() == null:
		return States.playerFall
	if Player.is_on_floor():
		return States.playerIdle
	
func enter_state():
	lastWallDirection = Player.get_next_to_wall()
	
func friction():
	Player.velocity.y *= slideFriction
