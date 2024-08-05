extends Node

var Player = null
var States = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	return null
	
	
func player_movement():
	Player.velocity.x = Player.movementInput.x * Player.SPEED
	
func exit_state():
	pass
	
func enter_state():
	pass
