extends KinematicBody2D

export var speed = 200
export (int) var player

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if player == 1:
		$AnimatedSprite.animation = "walk_1"
	else:
		$AnimatedSprite.animation = "walk_2"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var velocity = Vector2.ZERO
	
	# The instance is player 1
	if player == 1:
		if Input.is_action_pressed("p1_right"):
			velocity.x += 1
		if Input.is_action_pressed("p1_left"):
			velocity.x -= 1
		if Input.is_action_pressed("p1_down"):
			velocity.y += 1
		if Input.is_action_pressed("p1_up"):
			velocity.y -= 1
	# The instance is player 2
	else:
		if Input.is_action_pressed("p2_right"):
			velocity.x += 1
		if Input.is_action_pressed("p2_left"):
			velocity.x -= 1
		if Input.is_action_pressed("p2_down"):
			velocity.y += 1
		if Input.is_action_pressed("p2_up"):
			velocity.y -= 1
	
	# Mouvement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	move_and_slide(velocity, Vector2(0, -1))
	
	# Animation
	$AnimatedSprite.flip_v = false
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
