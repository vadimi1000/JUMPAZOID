extends Node2D

var walls = []

func _ready():
	for wall in $".".get_children():
		walls.append(wall)
		print(wall)
	
	for wall in walls:
		var wall_dimentions = wall.get_rect()
		var collision_shape = CollisionShape2D.new()
		var static_body = StaticBody2D.new()
		
		var wall_rect = wall.get_rect()
		wall.color = Color("888888")
		
		
		var rectshape = RectangleShape2D.new()
		rectshape.size = wall_rect.size
		collision_shape.set_shape(rectshape)
		
		collision_shape.global_position = wall.global_position + (wall_rect.size / 2)
		
		print(collision_shape.position)
		
		
		
		$".".add_child(collision_shape)
