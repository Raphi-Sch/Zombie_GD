extends Area2D

# External var (editor)
export (int) var player

# Local var
var tile_size = 32

# Use for inputs
var current_inputs
var p1_inputs = {"p1_right": Vector2.RIGHT,
			"p1_left": Vector2.LEFT,
			"p1_up": Vector2.UP,
			"p1_down": Vector2.DOWN}
var p2_inputs = {"p2_right": Vector2.RIGHT,
			"p2_left": Vector2.LEFT,
			"p2_up": Vector2.UP,
			"p2_down": Vector2.DOWN}

# Use for collision
onready var ray = $RayCast2D

# Use for smooth trasition between tiles
onready var tween = $Tween
export var speed = 5

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
	var texture
	if player == 1:
		texture = load("res://assets/texture/player_1.png")
	if player == 2:
		texture = load("res://assets/texture/player_2.png")
	
	$Sprite.texture = texture

func _unhandled_input(event):
	if tween.is_active():
		return
	if player == 1:
		current_inputs = p1_inputs
	if player == 2:
		current_inputs = p2_inputs
	for dir in current_inputs.keys():
		if event.is_action_pressed(dir):
			move(current_inputs[dir])

func move(vect_dir):
	ray.cast_to = vect_dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(vect_dir)

# Smooth transition between tiles
func move_tween(vect_dir):
	tween.interpolate_property(self, "position", position, position + vect_dir * tile_size, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
