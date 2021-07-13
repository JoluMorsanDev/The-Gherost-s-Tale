extends KinematicBody2D

var motion = Vector2()
var speed = -150
var inmunity = false
var state = "float"
var target = Vector2()
var player 
var life = 5
export (PackedScene) var Death

# Called when the node enters the scene tree for the first time.
func _ready():
	state = "float"
	player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if inmunity == true:
		motion.y += 32
	else:
		motion.y = 0
	if state == "float":
		motion.x = speed
		if speed == -150:
			scale.x = 1
		elif speed == 150:
			scale.x = -1
		motion = move_and_slide(motion, Vector2(0, -1))
	elif state == "attack":
		target = player.global_position
		if position.distance_to(target) > 40:
			motion = target - position
		if motion.length() > 0:
			if inmunity == false:
				motion = motion.normalized() * abs(speed) * 2.5
			else:
				motion = motion.normalized() * abs(speed) * 2
			$AnimatedSprite.speed_scale = 1.5
		else:
			$AnimatedSprite.speed_scale = 1
		if target.x - position.x > 0:
			scale.x = -1
		elif target.x - position.x < 0:
			scale.x = 1
		position += motion * delta
		$TurnTimer.stop()
	elif state == "block":
		speed = 0

func _on_TurnTimer_timeout():
	speed = -speed

# warning-ignore:unused_argument
func _on_GetPosArea_area_entered(area):
	state = "attack"

# warning-ignore:unused_argument
func _on_GetPosArea_area_exited(area):
	state = "float"
	$TurnTimer.start()

# warning-ignore:unused_argument
func _on_LifeArea_area_entered(area):
	$DamageSound.play()
	if life > 1:
		life -= 1
		inmunity = true
		$AnimatedSprite.modulate = Color(0, 0, 1, 1)
		$LifeArea/CollisionShape2D2.set_deferred("disabled", true)
		$InmunityTimer.start()
	else:
		var dead = Death.instance()
		get_parent().get_parent().add_child(dead)
		dead.scale.x = scale.x
		dead.global_position.x = global_position.x
		dead.global_position.y = global_position.y - 80
		queue_free()

func _on_InmunityTimer_timeout():
	inmunity = false
	$AnimatedSprite.modulate = Color(1, 1, 1, 1)
	$LifeArea/CollisionShape2D2.set_deferred("disabled", false)
