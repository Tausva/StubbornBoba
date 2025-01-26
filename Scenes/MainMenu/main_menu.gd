extends Node2D

@export var press_delay: float = .1

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _on_start_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	get_tree().change_scene_to_file("res://Scenes/GameScene/game_scene.tscn")


func _on_quit_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	get_tree().quit()
