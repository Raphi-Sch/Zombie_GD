extends Node

var player_round = 0

signal zombie_round

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func player_moved():
	player_round += 1
	if (player_round % 2 && player_round != 1):
		emit_signal("zombie_round")

func _on_Player_1_moved():
	player_moved()

func _on_Player_2_moved():
	player_moved()
