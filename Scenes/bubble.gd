class_name Bubble extends CharacterBody2D

@onready var dash_particles = $CPUParticles2D

@export var speed:int = 50000
@export var dash_speed: int = 100000
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 5.0

var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
var dash_timer: float = 0.0 
var cooldown_timer: float = 0.0
var can_jump: bool = false
var disable_vertical_movement: bool = false
var jump_activated = false
var bubble_exited_Area_count = 0;
var is_above_water = false

func _ready() -> void:
	dash_particles.emitting = false
	dash_particles.texture =$Sprite2D.texture
	pass 


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("bubble_left", "bubble_right", "bubble_up", "bubble_down")
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed * delta
	else:
		velocity = Vector2.ZERO

	if disable_vertical_movement and direction.y > 0:
		velocity = Vector2.ZERO
	print(disable_vertical_movement)
	if disable_vertical_movement and bubble_exited_Area_count == 1:
		velocity.y += -1000
		#can_jump = false
		is_above_water = true
	
	if is_above_water and bubble_exited_Area_count == 1:
		velocity.y += speed * delta
		
		#if disable_vertical_movement:
			#velocity = Vector2.ZERO
		#else:
			#velocity = direction.normalized() * speed * delta
	
	#if direction.y > 0 and disable_vertical_movement == true:
		#if jump_activated:
			#print("bomba")
			#velocity.y += speed * delta
		#else:
			#velocity = Vector2.ZERO
	#elif direction != Vector2.ZERO:
		#print("1")
		#velocity = direction.normalized() * speed * delta
	#else:
		#velocity = Vector2.ZERO

	if cooldown_timer > 0:
		cooldown_timer -= delta
		if cooldown_timer < 0:
			cooldown_timer = 0
	if is_dashing:
		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false
			cooldown_timer = dash_cooldown
			dash_particles.emitting = false
		else:
			velocity += dash_direction * dash_speed * delta
	
	if Input.is_action_just_pressed("bubble_dash") and cooldown_timer <= 0 and direction != Vector2.ZERO:
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
	can_jump = true
	disable_vertical_movement = true

	if can_jump:
		jump_activated = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	bubble_exited_Area_count += 1
	print(bubble_exited_Area_count)
	if bubble_exited_Area_count == 2:
		print("bingo2")
		disable_vertical_movement = false
	pass # Replace with function body.
