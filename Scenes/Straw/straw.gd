class_name Straw extends CharacterBody2D

signal sucked

@export var speed: int = 200
@export var puncture_point: Node2D
@export var suck_timeout_duration: float = 2
@export var suck_duration: float = .2
@export var drain_amuont: float = .01

@onready var sprite: Sprite2D = $Sprite2D
@onready var suck_cooldown_timer: Timer = $SuckCooldownTimer
@onready var suck_duration_timer: Timer = $SuckDurationTimer

var sprite_half_height: float
var can_suck: bool = true
var cup: Cup = null
var sucking: bool = false


func _ready() -> void:
	sprite_half_height = sprite.texture.get_height() * sprite.scale.y / 2


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("straw_left", "straw_right", "straw_up", "straw_down")
	direction = (direction as Vector2).normalized()
	if direction:
		velocity = speed * direction * delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	var sprite_direction: Vector2 = global_position.direction_to(puncture_point.global_position)
	sprite.position = sprite_direction * sprite_half_height
	
	var sprite_angle: float = puncture_point.global_position.angle_to_point(global_position)
	sprite.rotation = sprite_angle + deg_to_rad(-90)
	
	if can_suck and Input.get_action_strength("straw_suck"):
		sucking = true
		_suck()
	elif can_suck and sucking:
		suck_duration_timer.stop()
		suck_cooldown_timer.start(suck_timeout_duration)
		can_suck = false
		sucking = false


func _suck() -> void:
	if suck_duration_timer.time_left == 0:
		suck_duration_timer.start(suck_duration)
	
	if cup:
		cup.drain(drain_amuont)


func _on_sucking_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("tea"):
		cup = area.get_parent()


func _on_sucking_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("tea"):
		cup = null


func _on_suck_cooldown_timeout() -> void:
	can_suck = true


func _on_suck_duration_timer_timeout() -> void:
	can_suck = false
	suck_cooldown_timer.start(suck_timeout_duration)


func _on_sucking_area_body_entered(body: Node2D) -> void:
	if body is Bubble and sucking:
		(body as Bubble).die()
		sucked.emit()
		#sucking animation
