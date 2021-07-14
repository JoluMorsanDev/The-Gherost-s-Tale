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
var inmunity = false
var movement = true
var cameramove = false

#Declare signals
signal hit
signal heal
signal coin
signal fall
signal magma

func _ready():
	cameramove = false

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
		if inmunity == false:
			$AnimatedSprite.playing = false
			$AnimatedSprite.frame = 0
		else:
			$AnimatedSprite.playing = true
	#if claws_cooldown == true:
		#get_node("claws").scale.x = sprite.scale.x
	
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
			
	if Input.is_action_just_pressed("claws") and claws_cooldown == false and inmunity == false:
		$ClawsSound.play()
		claws_cooldown = true
		$ClawsCooldown.start()
		var claws = Claws.instance()
		add_child(claws)
		claws.name = "claws"
		claws.scale.x = sprite.scale.x
		$AnimatedSprite.hide()
	
	#move the player with motion vector
# warning-ignore:return_value_discarded
	if movement == true:
		motion = move_and_slide(motion, Vector2.UP)

#Inform that you got hit
# warning-ignore:unused_argument
func _on_DamageArea_body_entered(body):
	if inmunity == false:
		emit_signal("hit")
		inmunity = true
		$InmunityTimer.start()
		$AnimatedSprite.animation = "inmunity"
		motion.x = -motion.x
# warning-ignore:integer_division
		motion.y = -jump_force/3
		if claws_cooldown == true and get_node_or_null("claws") != null:
			get_node_or_null("claws").queue_free()
			$ClawsCooldown.stop()
			claws_cooldown = false
			$AnimatedSprite.show()

func _on_ClawsCooldown_timeout():
	get_node("claws").queue_free()
	$AnimatedSprite.show()
	yield(get_tree().create_timer(.3), "timeout")
	claws_cooldown = false

# warning-ignore:unused_argument
func _on_HealArea_area_entered(area):
	$HealTimer.start()

func _on_HealTimer_timeout():
	emit_signal("heal")

# warning-ignore:unused_argument
func _on_HealArea_area_exited(area):
	$HealTimer.stop()

func _on_InmunityTimer_timeout():
	inmunity = false
	$AnimatedSprite.animation = "default"

# warning-ignore:unused_argument
func _on_CoinArea_area_entered(area):
	emit_signal("coin")


func _on_VisibilityNotifier2D_screen_exited():
	if cameramove == false:
		emit_signal("fall")

func movement_block_loss():
	claws_cooldown = true
	$AnimatedSprite.animation = "death"
	$Light2D.enabled = false
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	$HealArea/CollisionShape2D.set_deferred("disabled", true)
	$CoinArea/CollisionShape2D.set_deferred("disabled", true)
	movement = false

func movement_block_win():
	claws_cooldown = true
	$AnimatedSprite.position.y = -70
	$AnimatedSprite.animation = "win"
	$AnimatedSprite.playing = true
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	$HealArea/CollisionShape2D.set_deferred("disabled", true)
	$CoinArea/CollisionShape2D.set_deferred("disabled", true)
	movement = false

func movement_block():
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	$HealArea/CollisionShape2D.set_deferred("disabled", true)
	$CoinArea/CollisionShape2D.set_deferred("disabled", true)
	movement = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		hide()

# warning-ignore:unused_argument
func _on_Lavaarea_area_entered(area):
	claws_cooldown = true
	$AnimatedSprite.animation = "death"
	$Light2D.enabled = false
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	$HealArea/CollisionShape2D.set_deferred("disabled", true)
	$CoinArea/CollisionShape2D.set_deferred("disabled", true)
	$Lavaarea/CollisionShape2D.set_deferred("disabled", true)
	movement = false
	emit_signal("magma")
