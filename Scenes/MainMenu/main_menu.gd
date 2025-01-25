extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/ButtonStart.connect("pressed", Callable(self, "_on_start_game_pressed"))
	$CanvasLayer/ButtonQuit.connect("pressed", Callable(self, "_on_quit_game_pressed"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameScene/game_scene.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
