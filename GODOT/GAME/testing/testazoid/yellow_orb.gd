extends Area2D


var in_orb = false
var disabled = false

@export var delay: float

func _ready():
	$Timer.wait_time = delay
	
func _input(event):
	if Input.is_action_just_pressed("jump") and in_orb and not disabled:
		$"../../../Player".velocity.y = -400
		
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.stop()
		$AnimationPlayer.play("used")
		
		if delay != 0 and not disabled:
			disabled = true
			$AnimationPlayer.queue("disabled")
			$Timer.start()
				
		
	
func _on_body_entered(body):
	if body.name == "Player":
		in_orb = true

func _on_body_exited(body):
	if body.name == "Player":
		in_orb = false


func _on_timer_timeout():
	disabled = false
	$AnimationPlayer.play("reenable")
