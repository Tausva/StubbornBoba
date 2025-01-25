class_name Bubble extends CharacterBody2D

@onready var dash_particles = $CPUParticles2D

@export var speed:int = 50000
@export var dash_speed: int = 100000
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 5.0
@export var jump_cooldown: float = 5.0
@export var collision_shape_water: CollisionShape2D 

var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
var dash_timer: float = 0.0 
var dash_cooldown_timer: float = 0.0

var jump_cooldown_timer: float = 0.0
var can_jump: bool = false
var jump_activated = false
var is_above_water = false


func _ready() -> void:
	dash_particles.emitting = false
	dash_particles.texture =$Sprite2D.texture


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("bubble_left", "bubble_right", "bubble_up", "bubble_down")
	
	if jump_activated:
		direction.y = 0 #reiks atnulinti
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed * delta
	else:
		velocity = Vector2.ZERO
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		if dash_cooldown_timer < 0:
			dash_cooldown_timer = 0
	if is_dashing:
		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false
			dash_cooldown_timer = dash_cooldown
			dash_particles.emitting = false
		else:
			velocity += dash_direction * dash_speed * delta
	
	if jump_cooldown_timer > 0:
		jump_cooldown_timer -= delta
		if jump_cooldown_timer < 0:
			jump_cooldown_timer = 0
	
	if jump_cooldown_timer <= 0:
		can_jump = true

	if Input.is_action_just_pressed("bubble_dash") and dash_cooldown_timer <= 0 and direction != Vector2.ZERO:
		_start_dash(direction)
	
	move_and_slide()


func die() -> void:
	print("uwu, I am dead step developer")


func _start_dash(direction: Vector2) -> void:
	is_dashing = true
	dash_timer = dash_duration
	dash_direction = direction.normalized()
	dash_particles.emitting = true
	dash_particles.rotation_degrees = dash_direction.angle() * 180 / PI + 180
	dash_particles.local_coords = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("water_filter"):
		pass
	
	collision_shape_water.disabled = true
	jump_activated = true
	if can_jump:
		print("ar tu ateini")
		call_deferred("collision_shape_water_disabled")
		can_jump = false
		jump_activated = true
		is_above_water = true
		jump_cooldown_timer = jump_cooldown
	else: 
		jump_activated = false

	if jump_cooldown_timer <= 0:
		call_deferred("collision_shape_water_enabled")
		is_above_water = false
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	#collision_shape_water_count += 1
	#print(collision_shape_water_count)
	#if collision_shape_water_count == 2 :
	#	call_deferred("collision_shape_water_enabled")
	#	collision_shape_water_count == 0
	pass # Replace with function body.


func collision_shape_water_disabled() -> void:
		collision_shape_water.disabled = true


func collision_shape_water_enabled() -> void:
	collision_shape_water.disabled = false


#func collision_shape_exited() -> void:
	#collision_shape_water.area
