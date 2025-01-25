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
