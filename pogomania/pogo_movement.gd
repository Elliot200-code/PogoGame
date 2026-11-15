extends Area2D

@export var raycast_a : RayCast2D
@export var raycast_b : RayCast2D
@export var death_a : RayCast2D
@export var death_b : RayCast2D
@export var death_c : RayCast2D

@export var audio_manager : Node

@export var gravitational_acceleration : float
@export var jump_force : float

@export var starting_position : Vector2

@export var rotation_speed : float

@export var death_time : float

@onready var death_timer : float = death_time * 2

var x_velocity : float = 0.0
var y_velocity : float = 0.0

var touching_ground = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	rotate_player()
	apply_gravity()
	change_position()
	incriment_timers()
	check_for_death()

	
func incriment_timers():
	death_timer += get_process_delta_time()

func change_position():
	position.x += x_velocity
	position.y += y_velocity

func apply_gravity():
	y_velocity += gravitational_acceleration

func bounce_horizontally():
	x_velocity = -sin(rotation) * jump_force
	y_velocity = cos(rotation) * jump_force
	y_velocity = -absf(y_velocity)

func bounce_vertically():
	x_velocity = cos(rotation) * jump_force
	y_velocity = sin(rotation) * jump_force
	y_velocity = -absf(y_velocity)

func bounce():
	var a_x = raycast_a.get_collision_point().x
	var a_y = raycast_a.get_collision_point().y
	var b_x = raycast_b.get_collision_point().x
	var b_y = raycast_b.get_collision_point().y
	if absf(a_x - b_x) > absf(a_y - b_y):
		print("H")
		bounce_horizontally()
	else:
		print("V")
		bounce_horizontally()
	audio_manager.bounce()
	

func check_for_death():
	if ((
		death_a.is_colliding() or
		death_b.is_colliding() or
		death_c.is_colliding()
		
	)  or position.y > 700 and position.y < 800) and not dead():
		death_timer = 0
		y_velocity = 30
		audio_manager.lose()
	if dead():
		rotation += .1
	if absf(death_timer - death_time) < .1:
		x_velocity = 0
		y_velocity = 0
		rotation = 0
		position = starting_position

func dead():
	return death_time > death_timer

func rotate_player():
	if Input.is_key_pressed(KEY_SPACE):
		rotation = 0
	if Input.is_key_pressed(KEY_LEFT) == Input.is_key_pressed(KEY_RIGHT):
		return
	if Input.is_key_pressed(KEY_RIGHT):
		rotation += rotation_speed
	if Input.is_key_pressed(KEY_LEFT):
		rotation -= rotation_speed


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("FloorBody") and not dead():
		bounce()
		



func _on_body_exited(body: Node2D) -> void:
	pass
