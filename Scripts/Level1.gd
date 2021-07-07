extends Node2D

var life = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.global_position = $SpawnPos.position

# warning-ignore:unused_argument
func _process(delta):
	if $Player.global_position.x > 640:
		$Camera2D.global_position.x = $Player.global_position.x
