extends KinematicBody2D

#Declare constants
const aceleration = 5000
const max_speed = 500
const friction = .25
const gravity = 900
const jump_force = 120

#Declare variables
var motion = Vector2.ZERO

func _physics_process(delta):
	#Get the keyboardInput to move x
	var x_input = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	
	#if you are pressing one key, you move and your walking animation will play, else, stop it with 0
	if x_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$AnimatedSprite.playing = true
	else:
		motion.x = lerp(motion.x, 0, friction)
	
	#If is touching the floor, and press up, your motion in y will be jump force
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jump_force
	
	#Put the vector motion y axis in gravity
	motion.y += gravity * delta
	
	#move the player with motion vector
# warning-ignore:return_value_discarded
	motion = move_and_slide(motion)
