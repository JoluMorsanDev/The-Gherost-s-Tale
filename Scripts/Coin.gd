extends Area2D

var eliminate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	down()

# warning-ignore:unused_argument
func _process(delta):
	if eliminate == true:
		position.y -= 2.5
		$AnimatedSprite.speed_scale = 2

# warning-ignore:unused_argument
func _on_Coin_area_entered(area):
	eliminate = true
	$Timer.start()
	$CollisionShape2D.set_deferred("disabled", true)

func down():
	if eliminate == false:
		position.y += 10
		yield(get_tree().create_timer(0.4),"timeout")
		up()

func up():
	if eliminate == false:
		position.y -= 10
		yield(get_tree().create_timer(0.4),"timeout")
		down()

func _on_Timer_timeout():
	queue_free()
