class_name Cup extends Area2D

signal empty

@onready var tea_collision_shape: CollisionShape2D = $Tea/CollisionShape2D

var fill_percentage: float = 1.0
var original_tea_height: float
var original_tea_position: Vector2


func _ready() -> void:
	original_tea_height = (tea_collision_shape.shape as RectangleShape2D).size.y
	original_tea_position = tea_collision_shape.position
	print(str(original_tea_height) + " " + str(original_tea_position))


func _process(delta: float) -> void: # testing, delet
	if Input.is_key_pressed(KEY_F):
		drain(0.01)
		print(str(original_tea_height) + " " + str(tea_collision_shape.position) + " " + str((tea_collision_shape.shape as RectangleShape2D).size.y))


func drain(percentage: float) -> void:
	fill_percentage -= percentage
	
	if fill_percentage < 0:
		fill_percentage = 0
		empty.emit()
	
	_update_play_area()


func _update_play_area() -> void:
	(tea_collision_shape.shape as RectangleShape2D).size.y = original_tea_height * fill_percentage
	tea_collision_shape.position.y = original_tea_position.y * fill_percentage
