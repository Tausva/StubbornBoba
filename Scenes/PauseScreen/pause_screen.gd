class_name PauseScreen extends Node2D

@export var press_delay: float = .1


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		if  visible:
			_exit_screen()
		else:
			visible = true
			get_tree().paused = true


func _exit_screen() -> void:
	visible = false
	get_tree().paused = false


func _on_exit_button_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	
	_exit_screen()


func _on_menu_button_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
