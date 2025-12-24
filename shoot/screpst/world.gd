extends Node2D

@onready var player = $plaery  # Исправлено имя узла (если он называется "player")
@onready var main_camera = $maincavera
func _ready() -> void:
	player.died.connect(_on_player_died)
	player.camera_remote_transform.remote_path = main_camera.get_path()
	 # Исправлено connect

func _on_player_died():
	print("Game Over")
	
	# Вариант 1: С использованием await (рекомендуется)
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()
	
	# Или Вариант 2: Через callback
	# get_tree().create_timer(3.0).timeout.connect(
	#     func(): get_tree().reload_current_scene()
	# )
	# Самый простой вариант - смерть при любом столкновении
