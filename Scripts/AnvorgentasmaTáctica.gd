extends KinematicBody2D

#Declare constants
const aceleration = 2000
const max_speed = 200
const friction = .3
const gravity = 1600
const jump_force = 800
const air_friction = 0.02

#Declare variables
var motion = Vector2.ZERO
onready var sprite = $AnimatedSprite
var x_input = -1
export (PackedScene) var Quesontasma
var life = 3

func _physics_process(delta):
	#Get the keyboardInput to move x
	if $Side.is_colliding():
		x_input = -x_input
		scale.x = -scale.x
	
	#if you are pressing one key, you move and your walking animation will play
	if x_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$AnimatedSprite.playing = true
	if x_input == 0 or !is_on_floor():
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	
	#Put the vector motion y axis in gravity
	motion.y += gravity * delta
	
	#If is touching the floor, and press up, your motion in y will be jump force, if you aren't pressing any key, you'll stop
	if is_on_floor():
		if x_input == 0:
				motion.x = lerp(motion.x, 0, friction)
		if $Jumpside.is_colliding() and !$Jumpup.is_colliding():
			motion.y = -jump_force
		if !$Cliff.is_colliding():
			x_input = -x_input
			scale.x = -scale.x
	else:
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_friction)
	
	#move the player with motion vector
# warning-ignore:return_value_discarded
	motion = move_and_slide(motion, Vector2.UP)



func _on_BulletTimer_timeout():
	var last_motion = x_input
	var quesontasma = Quesontasma.instance()
	x_input = 0
	yield(get_tree().create_timer(0.5),"timeout")
	get_parent().add_child(quesontasma)
	quesontasma.direction = last_motion
	quesontasma.global_position.y = global_position.y - 40
	quesontasma.global_position.x = global_position.x + 60 * last_motion
	yield(get_tree().create_timer(0.5),"timeout")
	x_input = last_motion
	$BulletTimer.start()

# warning-ignore:unused_argument
func _on_DamageArea_area_entered(area):
	if life > 0:
		life -= 1
	else:
		queue_free()
