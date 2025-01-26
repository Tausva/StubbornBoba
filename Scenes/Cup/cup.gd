class_name Cup extends StaticBody2D

signal empty

@onready var tea_collision_shape: CollisionShape2D = $Tea/CollisionShape
@onready var tea_sprite: Sprite2D = $Tea/CupShapeSprite/TeaSprite
@onready var cup_shape_sprite: Sprite2D = $Tea/CupShapeSprite
@onready var boba_activation_zone: Area2D = $BobaActivationZone
@onready var boba_no_go_zone: StaticBody2D = $BobaNoGoZone
@onready var surface_waves: AnimatedSprite2D = $Tea/CupShapeSprite/SurfaceWaves

var fill_percentage: float = 1.0
var original_tea_height: float
var original_tea_position: Vector2
var original_tea_sprite_scale: float
var original_tea_sprite_position: float
var original_boba_activation_zone_positon: float
var original_boba_no_go_zone_position: float
var original_surface_waves_position: float


func _ready() -> void:
	original_tea_height = (tea_collision_shape.shape as RectangleShape2D).size.y
	original_tea_position = tea_collision_shape.position
	original_tea_sprite_scale = tea_sprite.scale.y
	original_tea_sprite_position = tea_sprite.position.y
	original_boba_activation_zone_positon = boba_activation_zone.position.y
	original_boba_no_go_zone_position = boba_no_go_zone.position.y
	original_surface_waves_position = surface_waves.position.y


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_F):
		drain(.01)


func drain(percentage: float) -> void:
	fill_percentage -= percentage
	
	if fill_percentage < 0:
		fill_percentage = 0
		empty.emit()
	
	_update_play_area()


func _update_play_area() -> void:
	(tea_collision_shape.shape as RectangleShape2D).size.y = original_tea_height * fill_percentage
	tea_collision_shape.position.y = original_tea_position.y * fill_percentage
	
	tea_sprite.scale.y = original_tea_sprite_scale * fill_percentage
	tea_sprite.position.y = 530 * (1 - fill_percentage) + original_tea_sprite_position * fill_percentage
	
	surface_waves.position.y = 434 * (1 - fill_percentage) + original_surface_waves_position * fill_percentage
	
	boba_activation_zone.position.y = 852  * (1 - fill_percentage) + original_boba_activation_zone_positon * fill_percentage
	
	boba_no_go_zone.position.y = 838  * (1 - fill_percentage) + original_boba_no_go_zone_position * fill_percentage
