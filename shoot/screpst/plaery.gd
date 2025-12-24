extends CharacterBody2D
class_name Plaery
signal died

@onready var camera_remote_transform = $cameraRemoteTransform2D
@onready var shoot_raycast  = $shootRayCast2D
var speed = 300
#мышка
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	 #выстерл
	if Input.is_action_just_pressed("shoot"):
		if shoot_raycast. is_colliding():
			var colid = shoot_raycast.get_collider()
			if colid is StaticBody2D:
				print ("shoot a box")
			elif colid is Enemy:
				colid.take_damaga(1)
				
#движение
func _physics_process(delta: float) -> void:
	var move_dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	# Если есть ввод - двигаемся, если нет - стоим
	if move_dir.length() > 0:
		move_dir = move_dir.normalized()  # Нормализуем только при движении
		velocity = move_dir * speed
	else:
		velocity = Vector2.ZERO  # Останавливаем персонажа
	
	move_and_slide()

#смерть
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy :
		died.emit()
		queue_free()
