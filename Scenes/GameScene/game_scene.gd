class_name GameScene extends Node2D

@onready var cup: Cup = $Playground/Cup
@onready var straw: Straw = $Playground/Straw
@onready var intro_timer: Timer = $IntroTimer

@export var start_duration: float = 2.5


func _ready() -> void:
	cup.empty.connect(_on_bubble_victory)
	straw.sucked.connect(_on_straw_victory)
	
	get_tree().paused = true
	intro_timer.start(start_duration)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _disconnect() -> void:
	cup.empty.disconnect(_on_bubble_victory)
	straw.sucked.disconnect(_on_straw_victory)


func _on_bubble_victory() -> void:
	await get_tree().create_timer(.4).timeout
	print("bubble won!")
	_disconnect()


func _on_straw_victory() -> void:
	await get_tree().create_timer(.4).timeout
	print("straw won!")
	_disconnect()


func _on_intro_timer_timeout() -> void:
	get_tree().paused = false
