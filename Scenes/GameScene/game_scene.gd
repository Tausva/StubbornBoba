class_name GameScene extends Node2D

@onready var cup: Cup = $Playground/Cup
@onready var straw: Straw = $Playground/Straw
@onready var bubble: Bubble = $Playground/Bubble
@onready var intro_timer: Timer = $IntroTimer
@onready var blink_timer: Timer = $Foreground/Bubble/BubbleBlinkTimer
@onready var pause_screen: PauseScreen = $PauseScreen
@onready var dash_ability: Ability = $Playground/ControlsUI/DashAbility
@onready var move_ability: Ability = $Playground/ControlsUI/MoveAbility
@onready var suck_ability: Ability = $Playground/ControlsUI/SuckAbility

@onready var bubble_blink_time_delay: float = 2
@export var start_duration: float = 2.5


func _ready() -> void:
	cup.empty.connect(_on_bubble_victory)
	straw.sucked.connect(_on_straw_victory)
	
	get_tree().paused = true
	intro_timer.start(start_duration)
	blink_timer.start(bubble_blink_time_delay)
	
	pause_screen.visible = false

	$AudioStreamPlayer2DBubblePop.play()
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2DMusic.play()
	
	straw.suck_cooldown_started.connect(_on_straw_suck_cooldown_started)
	bubble.dash_cooldown_started.connect(_on_bubble_dash_cooldown_started)
	bubble.jump_cooldown_started.connect(_on_bubble_jump_cooldown_started)
	cup.threasholf_reached.connect(_on_tea_threashold_reached)


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


func _on_straw_suck_cooldown_started(duration: float) -> void:
	suck_ability.start_ability_timer(duration)


func _on_bubble_dash_cooldown_started(duration: float) -> void:
	dash_ability.start_ability_timer(duration)


func _on_bubble_jump_cooldown_started(duration: float) -> void:
	move_ability.start_ability_timer(duration)


func _on_bubble_blink_timer_timeout() -> void:
	var animations = ["Blink", "Drink", "Suck"]
	var random_animation = animations[randi() % animations.size()]
	$Foreground/Bubble.play(random_animation)


func _on_tea_threashold_reached() -> void:
	bubble.enable_jumping()
