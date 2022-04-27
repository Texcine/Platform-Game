extends KinematicBody2D


# Declare member variables here. Examples:
var timer = 300
var motion = Vector2()
var gravityforce
var dir = "esquerda"
var time = 0
var speed = 50
var damaged = false
#onready var gravityforce = self.get_parent().find_node("Jogador")


# Called when the node enters the scene tree for the first time.
func _ready():
	gravityforce = self.get_parent().find_node("Jogador").gravityForce


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion.y = motion.y + gravityforce
	
	_MoveEnemy()
	_Colisao()
	motion = move_and_slide(motion, Vector2.UP)
	
	 
func _MoveEnemy():
	if damaged == false:
		if dir == "esquerda":
			get_child(0).flip_h = true
			get_child(0).animation = "walk"
			motion.x = speed
			time = time + 1
			
			if time == timer:
				dir = "direita"
				time = 0
				
		elif dir == "direita":
			get_child(0).flip_h = false
			get_child(0).animation = "walk"
			motion.x = -speed
			time = time +1
			
			if time == timer:
				dir = "esquerda"
				time = 0
			
func _Colisao():
	if get_slide_count() > 0:
		if get_slide_collision(0).collider.name == "dirr":
			dir = "direita"
			time = 0
		elif get_slide_collision(0).collider.name == "esqq":
			dir = "esquerda"
			time = 0
			


func _on_Area2D_body_entered(body):
	if body.name == "Jogador":
		print(body.name)
		damaged = true
		get_child(0).animation = "hit"	
	if body.name == "FireBall":
		print(body.name)

func _on_Area2D_body_exited(body):
	if body.name == "Jogador" or body.name == "newFireBall":
		damaged = false


func _on_EnemyArea_area_entered(area):
	if area.name == "FireBallArea":
		damaged = true
		get_child(0).animation = "hit"	


func _on_EnemyArea_area_exited(area):
	if area.name == "FireBallArea":
		damaged = false
