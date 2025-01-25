extends Node2D


@export var speed:int = 500

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("bubble_left", "bubble_right", "bubble_up", "bubble_down")
	if direction != Vector2.ZERO:
		position += direction.normalized() * speed * delta
