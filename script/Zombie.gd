extends Area2D

export (int) var pos_x
export (int) var pos_y

var tile_size = 32
onready var ray = $RayCast2D
onready var tween = $Tween
export var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Link_zombie_round():
	move(Vector2.UP)

func move(vect_dir):
	ray.cast_to = vect_dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(vect_dir)

# Smooth transition between tiles
func move_tween(vect_dir):
	tween.interpolate_property(self, "position", position, position + vect_dir * tile_size, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
