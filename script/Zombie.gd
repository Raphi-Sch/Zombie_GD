extends Area2D

export (int) var pos_x
export (int) var pos_y
export var speed = 5

var tile_size = 32
var target = Vector2.ZERO

onready var ray = $RayCast2D
onready var tween = $Tween
onready var players = get_tree().get_nodes_in_group("players")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Link_zombie_round():
	choose_target()
	if(!move(direction_target())):
		possible_path()

func move(vect_dir):
	ray.cast_to = vect_dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(vect_dir)
		return true
	return false

# Smooth transition between tiles
func move_tween(vect_dir):
	tween.interpolate_property(self, "position", position, position + vect_dir * tile_size, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func choose_target():
	var distance_player_1 = round(sqrt(pow(players[0].position.x - position.x, 2) + pow(players[0].position.y - position.y, 2)))
	var distance_player_2 = round(sqrt(pow(players[1].position.x - position.x, 2) + pow(players[1].position.y - position.y, 2)))
	if(distance_player_1 < distance_player_2):
		target = Vector2(players[0].position.x - position.x, players[0].position.y - position.y)
	else:
		target = Vector2(players[1].position.x - position.x, players[1].position.y - position.y)

func direction_target():
	if(abs(target.x) > abs(target.y)):
		if(target.x > 0):
			return Vector2.RIGHT
		elif(target.x < 0):
			return Vector2.LEFT
	else:
		if(target.y > 0):
			return Vector2.DOWN
		elif(target.y < 0):
			return Vector2.UP

func possible_path():
	if(try_path(Vector2.UP)):
		pass
	if(try_path(Vector2.RIGHT)):
		pass
	if(try_path(Vector2.DOWN)):
		pass
	if(try_path(Vector2.LEFT)):
		pass


func try_path(input_vector2):
	ray.cast_to = input_vector2 * tile_size
	ray.force_raycast_update()
	if (!ray.is_colliding()):
		move_tween(input_vector2)
		return true
	return false

