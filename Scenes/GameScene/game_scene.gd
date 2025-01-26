class_name GameScene extends Node2D

@onready var cup: Cup = $Playground/Cup
@onready var straw: Straw = $Playground/Straw
@onready var intro_timer: Timer = $IntroTimer
@onready var pause_screen: PauseScreen = $PauseScreen

@export var start_duration: float = 2.5


func _ready() -> void:
	cup.empty.connect(_on_bubble_victory)
	straw.sucked.connect(_on_straw_victory)
	
	get_tree().paused = true
	intro_timer.start(start_duration)
	
	pause_screen.visible = false


func _disconnect() -> void:
	cup.empty.disconnect(_on_bubble_victory)
	straw.sucked.disconnect(_on_straw_victory)


func _on_bubble_victory() -> void:
	_disconnect()
	
	await get_tree().create_timer(.4).timeout
	
	get_tree().change_scene_to_file("res://Scenes/WinScreen/bubble_win_scene.tscn")


func _on_straw_victory() -> void:
	_disconnect()
	
	await get_tree().create_timer(.4).timeout
	
	get_tree().change_scene_to_file("res://Scenes/WinScreen/straw_win_scene.tscn")


func _on_intro_timer_timeout() -> void:
	get_tree().paused = false
