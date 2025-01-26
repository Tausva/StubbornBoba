class_name Ability extends Node2D

@export var ability_texture: Texture
@export var lower_position: float = 63

@onready var filter: Sprite2D = $Filter
@onready var fill: Sprite2D = $Filter/Fill
@onready var filled: Sprite2D = $Filter/Filled

var timer: float = 0
var total_timer: float = 0
var original_scale: float
var original_position: float


func _ready() -> void:
	filter.texture = ability_texture
	
	original_scale = fill.scale.y
	original_position = fill.position.y


func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
		if timer < 0:
			timer = 0

		if timer <= 0:
			filled.visible = true
		else:
			var fill_percentage: float = timer / total_timer
			fill.scale.y = original_scale * fill_percentage
			fill.position.y = lower_position - (lower_position * fill_percentage)


func start_ability_timer(duration: float) -> void:
	timer = duration
	total_timer = duration
	filled.visible = false
