extends KinematicBody2D

#Declare constants
const aceleration = 5000
const max_speed = 500
const friction = .20
const gravity = 1200
const jump_force = 900
const air_friction = 0.02

#Declare variables
var motion = Vector2.ZERO
onready var sprite = $AnimatedSprite
export (PackedScene) var Claws
var claws_cooldown = false

#Declare signals
signal hit
signal heal

func _physics_process(delta):
	#Get the keyboardInput to move x
	var x_input = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	
	#if you are pressing one key, you move and your walking animation will play
	if x_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$AnimatedSprite.playing = true
		sprite.scale.x = x_input
	if x_input == 0 or !is_on_floor():
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	if claws_cooldown == true:
		get_node("claws").scale.x = sprite.scale.x
	
	#Put the vector motion y axis in gravity
	motion.y += gravity * delta
	
	#If is touching the floor, and press up, your motion in y will be jump force, if you aren't pressing any key, you'll stop
	if is_on_floor():
		if x_input == 0:
				motion.x = lerp(motion.x, 0, friction)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jump_force
	else:
# warning-ignore:integer_division
		if Input.is_action_just_released("ui_up") and motion.y < -jump_force/2:
# warning-ignore:integer_division
			motion.y = -jump_force/2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_friction)
			
	if Input.is_action_just_pressed("claws") and claws_cooldown == false:
		claws_cooldown = true
		$ClawsCooldown.start()
		var claws = Claws.instance()
		add_child(claws)
		claws.name = "claws"
		claws.scale.x = sprite.scale.x
		$AnimatedSprite.hide()
	
	#move the player with motion vector
# warning-ignore:return_value_discarded
	motion = move_and_slide(motion, Vector2.UP)

#Inform that you got hit
# warning-ignore:unused_argument
func _on_DamageArea_body_entered(body):
	emit_signal("hit")

func _on_ClawsCooldown_timeout():
	get_node("claws").queue_free()
	claws_cooldown = false
	$AnimatedSprite.show()

func _on_HealArea_area_entered(area):
	emit_signal("heal")
