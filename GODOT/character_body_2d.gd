extends CharacterBody2D


var speed = 300
var accel = 0
const JUMP_VELOCITY = -400.0
var in_orb: bool
var in_green_orb: bool
var in_red_orb: bool
var grav_normal = true
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if grav_normal:
			velocity += get_gravity() * delta
			
	if not is_on_ceiling():
		if not grav_normal:
			velocity -= get_gravity() * delta
	
	if Input.is_action_just_pressed("e"):
		velocity.x = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print("FLOOR")
		if grav_normal:
			velocity.y = JUMP_VELOCITY
			$AnimationPlayer.play("jump")
			
	if Input.is_action_just_pressed("jump") and is_on_ceiling():
		if not grav_normal:
			velocity.y = 400
			
	
	# double jump
	if Input.is_action_just_pressed("jump") and in_orb:
		velocity.y = JUMP_VELOCITY
	
	# double jump high
	if Input.is_action_just_pressed("jump") and in_red_orb:
		velocity.y = JUMP_VELOCITY - 400
	
	if Input.is_action_just_pressed("jump") and in_green_orb:
		grav_normal = not grav_normal
		if $"../green orbs/AnimationPlayer".is_playing():
			$"../green orbs/AnimationPlayer".stop()
		$"../green orbs/AnimationPlayer".play("orb use")
		
	if Input.is_action_pressed("shift"):
		speed += 20
		speed = clamp(speed, 300, 1000)
	else:
		speed -= 50
		speed = clamp(speed, 300, 1000)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var lastdir
	if direction != 0:
		# Increase acceleration while moving

		accel += 0.04
		velocity.x = direction * speed * accel
	else:
		# Gradually move velocity.x toward 0 when no input
		velocity.x = move_toward(velocity.x, 0, 0.04 * speed)
		accel -= 0.14
	# Clamp acceleration between 0 and 1
	accel = clamp(accel, 0, 1)

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "player":
		in_orb = true


func _on_area_2d_body_exited(body):
	if body.name == "player":
		in_orb = false


func _on_red_orb_body_entered(body):
	if body.name == "player":
		in_red_orb = true
	



func _on_red_orb_body_exited(body):
	if body.name == "player":
		in_red_orb = false


func _on_green_orb_body_entered(body):
	if body.name == "player":
		in_green_orb = true


func _on_green_orb_body_exited(body):
	if body.name == "player":
		in_green_orb = false
