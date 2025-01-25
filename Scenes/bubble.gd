extends Node2D


@export var speed:int = 200

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var directions = Input.get_vector("bubble_left","bubble_right","bubble_up","bubble_down")
	#position += directions * speed * delta
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("bubble_left", "bubble_right", "bubble_up", "bubble_down")
	if direction != Vector2.ZERO:
		position += direction.normalized() * speed * delta#func _on_move_request(direction: Vector2)
