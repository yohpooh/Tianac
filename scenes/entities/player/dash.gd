extends "states.gd"

var dashDirection = Vector2.ZERO
var dashSpeed = 340

var isDashing = false
@export var dashDuration = .2
@onready var dashDurationTimer = $DashDuration

func update(delta):
	Player.velocity = dashDirection * dashSpeed
	if isDashing:
		if Player.is_on_floor():
			return States.playerIdle
		else:
			return States.playerFall
	return null

func enter_state():
	Player.canDash = false
	set_dash_direction(Player.movementInput)
	dashDurationTimer.start(dashDuration)

func set_dash_direction(input_direction):
	if Player.movementInput != Vector2.ZERO:
		dashDirection = Player.movementInput.normalized()
	else:
		dashDirection = Player.lastDirection.normalized()

func exit_state():
	Player.velocity = Vector2.ZERO
	isDashing = false

func _on_timer_timeout():
	isDashing = true
