extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/ButtonStart.connect("pressed", Callable(self, "_on_start_game_pressed"))
	$CanvasLayer/ButtonQuit.connect("pressed", Callable(self, "_on_quit_game_pressed"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_start_game_pressed() -> void:
	var new_texture = preload("res://Scenes/MainMenu/start unclicked.png")
	$CanvasLayer/ButtonStart/Sprite2D.texture = new_texture
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/GameScene/game_scene.tscn")


func _on_quit_game_pressed() -> void:
	var new_texture = preload("res://Scenes/MainMenu/quit unclicked.png")
	$CanvasLayer/ButtonQuit/Sprite2D.texture = new_texture
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
