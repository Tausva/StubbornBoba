class_name Bubble extends CharacterBody2D

signal dash_cooldown_started(duration: float)
signal jump_cooldown_started(duration: float)

const gravity: float = 500

@onready var dash_particles = $CPUParticles2D

@export var speed: int = 50000
@export var dash_speed: int = 100000
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 5.0
@export var jump_cooldown: float = 1.0
@export var jump_velocity: int = 800

var collision_shape_water: CollisionShape2D
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
var dash_timer: float = 0.0 
var dash_cooldown_timer: float = 0.0

var jump_cooldown_timer: float = 0.0
var can_jump: bool = false
var jump_activated: bool = false
var is_above_water: bool = false
var jump_enabled: bool = false


func _ready() -> void:
	dash_particles.emitting = false
	dash_particles.texture = $Sprite2D.texture
	collision_shape_water = get_tree().get_first_node_in_group("baba_no_go_zone")


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("bubble_left", "bubble_right", "bubble_up", "bubble_down")
	
	if !jump_activated:
		if direction != Vector2.ZERO:
			velocity = direction.normalized() * speed * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity.y += gravity * delta
		velocity.x = direction.x * speed * delta
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		if dash_cooldown_timer < 0:
			dash_cooldown_timer = 0
	if is_dashing:
		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false
			dash_cooldown_timer = dash_cooldown
			dash_cooldown_started.emit(dash_cooldown)
			dash_particles.emitting = false
		else:
			velocity += dash_direction * dash_speed * delta
	
	if jump_cooldown_timer > 0:
		jump_cooldown_timer -= delta
		if jump_cooldown_timer < 0:
			jump_cooldown_timer = 0
	
	if jump_cooldown_timer <= 0 and jump_enabled:
		can_jump = true

	if Input.is_action_just_pressed("bubble_dash") and dash_cooldown_timer <= 0 and direction != Vector2.ZERO:
		_start_dash(direction)
	
	move_and_slide()


func enable_jumping() -> void:
	jump_enabled = true
	jump_cooldown_started.emit(.1)


func die() -> void:
	queue_free()


func _start_dash(direction: Vector2) -> void:
	is_dashing = true
	dash_timer = dash_duration
	dash_direction = direction.normalized()
	dash_particles.emitting = true
	dash_particles.rotation_degrees = dash_direction.angle() * 180 / PI + 180
	dash_particles.local_coords = false
	$DashAudio.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("water_filter"):
		pass
	
	if can_jump and !jump_activated and !is_above_water:
		call_deferred("_collision_shape_water_disabled")
		jump_activated = true
		velocity.y = -jump_velocity


func _on_area_2d_area_exited(area: Area2D) -> void:
	if !area.is_in_group("water_filter"):
		pass
	
	if !is_above_water and jump_activated:
		is_above_water = true
	elif jump_activated and is_above_water:
		call_deferred("_collision_shape_water_enabled")
		jump_activated = false
		can_jump = false
		is_above_water = false
		jump_cooldown_timer = jump_cooldown
		jump_cooldown_started.emit(jump_cooldown)


func _collision_shape_water_disabled() -> void:
	collision_shape_water.disabled = true


func _collision_shape_water_enabled() -> void:
	collision_shape_water.disabled = false
