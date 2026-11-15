extends Sprite2D

@export var camera : Camera2D
@export var player : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = camera.get_screen_center_position() - Vector2(0,80) + player.position * Vector2(.01,.01)
