class_name GameScene extends Node2D

@onready var cup: Cup = $Playground/Cup
@onready var straw: Straw = $Playground/Straw


func _ready() -> void:
	cup.empty.connect(_on_bubble_victory)
	straw.sucked.connect(_on_straw_victory)


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _disconnect() -> void:
	cup.empty.disconnect(_on_bubble_victory)
	straw.sucked.disconnect(_on_straw_victory)


func _on_bubble_victory() -> void:
	print("bubble won!")
	_disconnect()


func _on_straw_victory() -> void:
	print("straw won!")
	_disconnect()
