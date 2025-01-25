class_name Cup extends StaticBody2D

signal empty

@onready var tea_collision_shape: CollisionShape2D = $Tea/CollisionShape
@onready var tea_sprite: Sprite2D = $Tea/CupShapeSprite/TeaSprite
@onready var cup_shape_sprite: Sprite2D = $Tea/CupShapeSprite

var fill_percentage: float = 1.0
var original_tea_height: float
var original_tea_position: Vector2
var original_tea_sprite_scale: float


func _ready() -> void:
	original_tea_height = (tea_collision_shape.shape as RectangleShape2D).size.y
	original_tea_position = tea_collision_shape.position
	original_tea_sprite_scale = tea_sprite.scale.y


func drain(percentage: float) -> void:
	fill_percentage -= percentage
	
	if fill_percentage < 0:
		fill_percentage = 0
		empty.emit()
	
	_update_play_area()


func _update_play_area() -> void:
	(tea_collision_shape.shape as RectangleShape2D).size.y = original_tea_height * fill_percentage
	tea_collision_shape.position.y = original_tea_position.y * fill_percentage
	
	var position_to_go = cup_shape_sprite.position.y / cup_shape_sprite.scale.y * -1
	tea_sprite.scale.y = original_tea_sprite_scale * fill_percentage
	tea_sprite.position.y = position_to_go - position_to_go * fill_percentage
