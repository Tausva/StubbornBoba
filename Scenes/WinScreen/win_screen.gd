extends Node2D

@export var press_delay: float = .1

func _ready() -> void:
	$WinerAudio.play()

func _on_exit_button_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
