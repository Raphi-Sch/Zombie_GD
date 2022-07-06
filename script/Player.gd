extends Area2D

export (int) var player

var tile_size = 32
var p1_inputs = {"p1_right": Vector2.RIGHT,
			"p1_left": Vector2.LEFT,
			"p1_up": Vector2.UP,
			"p1_down": Vector2.DOWN}

var p2_inputs = {"p2_right": Vector2.RIGHT,
			"p2_left": Vector2.LEFT,
			"p2_up": Vector2.UP,
			"p2_down": Vector2.DOWN}

var current_inputs
onready var ray = $RayCast2D

# Called when the node enters the scene tree for the first time.
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
	if player == 1:
		current_inputs = p1_inputs
	if player == 2:
		current_inputs = p2_inputs
	
	for dir in current_inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.cast_to = current_inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += current_inputs[dir] * tile_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
