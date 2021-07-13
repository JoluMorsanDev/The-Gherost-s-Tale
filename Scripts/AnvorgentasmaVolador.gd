extends KinematicBody2D

var motion = Vector2()
var speed = -100
var inmunity = false
var state = "float"
var target = Vector2()
var player 

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
		motion = move_and_slide(motion, Vector2(0, -1))
	elif state == "attack":
		target = player.global_position
		if position.distance_to(target) > 40:
			motion = target - position
		if motion.length() > 0:
			motion = motion.normalized() * abs(speed) * 2
			$AnimatedSprite.speed_scale = 1.5
		else:
			$AnimatedSprite.speed_scale = 1
		if inmunity == false:
			position += motion * delta
		$TurnTimer.stop()
	elif state == "block":
		speed = 0

func _on_TurnTimer_timeout():
	scale.x = -scale.x
	speed = -speed

func _on_GetPosArea_area_entered(area):
	state = "attack"

func _on_GetPosArea_area_exited(area):
	state = "float"
	$TurnTimer.start()
