extends KinematicBody2D

var motion = Vector2()
var speed = 70
var jumpForce = 245
var gravityForce = 10
var isJumping = false
var fireBall = preload("res://Instatiables/FireBall.tscn")
var life = 100
var dano = 20

func _physics_process(delta):
	
	if life <= 0:
		print("morri")
		get_tree().change_scene("res://Scenes/Game.tscn")
	
	motion.y = motion.y + gravityForce
	
	if Input.is_key_pressed(KEY_D):
		motion.x = speed
		get_child(0).flip_h = false
		if isJumping == false:
			get_child(0).animation = "walk"
	elif Input.is_key_pressed(KEY_A):
		motion.x = -speed
		get_child(0).flip_h = true
		if isJumping == false:
			get_child(0).animation = "walk"
	else:
		motion.x = 0
		if isJumping == false:
			get_child(0).animation = "idle"
	
	if is_on_floor():
			isJumping = false
			if Input.is_action_just_pressed("jump"):
				isJumping = true
				motion.y = -jumpForce
				get_child(0).animation = "jump"
				
##tiro##
	if Input.is_action_just_pressed("shoot"):
		var newFireBall = fireBall.instance()
		newFireBall.global_position = position
		get_parent().add_child(newFireBall)
			
##Colisões##
	if get_slide_count() > 0:
		if get_slide_collision(0).collider.name == "DeathZone":
			get_tree().change_scene("res://Scenes/Game.tscn")



	motion = move_and_slide(motion, Vector2.UP)
