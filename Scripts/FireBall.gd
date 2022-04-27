extends KinematicBody2D

var bulletSpeed = 2

func _ready():
	look_at(get_global_mouse_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(Vector2(1,0).rotated(rotation)*bulletSpeed)


func _on_Area2D_area_entered(area):
	if area.name == "EnemyArea":
		$AnimatedSprite.visible = false
		$Timer.start()
		

func _on_Timer_timeout():
	queue_free()
