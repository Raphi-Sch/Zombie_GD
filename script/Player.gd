extends Area2D

export var speed = 200

var screen_size
var player = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	$AnimatedSprite.flip_v = false
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
