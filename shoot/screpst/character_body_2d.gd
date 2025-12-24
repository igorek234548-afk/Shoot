extends CharacterBody2D

class_name Enemy
@onready var animeplaery = $take_dameg
var plaery:Plaery = null
var speed : float =70
var dectore:= Vector2.ZERO
var hit_point:int = 3


#камера врага
func _process(delta: float) -> void:
	if plaery != null:
		look_at(plaery.global_position)
#ДВИЖЕНИЕ 
func _physics_process(delta: float) -> void:
	if plaery != null:
		var enemy_to_player = (plaery.global_position - global_position)
		dectore =enemy_to_player .normalized()
		if dectore.length() > 0:
			dectore = dectore.normalized()
			velocity = dectore * speed
		else:
			velocity = Vector2.ZERO  # Останавливаем персонажа
			pass
		move_and_slide()  # Останавливаем персонажа
	
	move_and_slide()

# обнаружение персонажа
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Plaery:
		if plaery == null:
			plaery = body
			print(name + "found the player")

# потеря персонажа
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Plaery:
		if plaery != null:
			plaery = null
			print(name + "lost the player")
			
			
#смерть врага и анимация урона
func take_damaga(amoount: int):
	if amoount > 0:
		hit_point-=amoount
		animeplaery.play("take_damaga")
		if hit_point <=0:
			print("enemy dident")
			queue_free()
