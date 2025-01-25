class_name Straw extends CharacterBody2D

@export var speed: int = 200
@export var puncture_point: Node2D

@onready var sprite: Sprite2D = $Sprite2D

var sprite_half_height: float


func _ready() -> void:
	sprite_half_height = sprite.texture.get_height() * sprite.scale.y / 2


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("straw_left", "straw_right", "straw_up", "straw_down")
	direction = (direction as Vector2).normalized()
	if direction:
		velocity = speed * direction
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	var sprite_direction: Vector2 = global_position.direction_to(puncture_point.global_position)
	sprite.position = sprite_direction * sprite_half_height
	
	var sprite_angle: float = puncture_point.global_position.angle_to_point(global_position)
	sprite.rotation = sprite_angle + deg_to_rad(-90)
