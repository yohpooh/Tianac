extends "state.gd"

var canJump = true
@export var cayoteJumpDuration = .2
@onready var CayoteTimer = $CayoteTimer

func update(delta):
	player_movement()
	Player.gravity(delta)
	if Player.jumpInputActuation and canJump:
		return States.playerJump
	if Player.is_on_floor():
		return States.playerIdle
	if Player.get_next_to_wall() != Vector2.ZERO: 
		return States.playerSlide
	return null
		
func enter_state():
	if Player.previousState == States.playerMove or Player.previousState == States.playerIdle:
		canJump = true
		CayoteTimer.start(cayoteJumpDuration)
	else:
		canJump = false
	
func _process(delta):
	pass
	
func _on_cayote_timer_timeout():
	canJump = false