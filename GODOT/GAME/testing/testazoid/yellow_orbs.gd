extends Node2D

func _ready():
	for orb in $"orbs pos".get_children():

		var color_rect = ColorRect.new()
		var collision_shape = CollisionShape2D.new()
		var area = Area2D.new()
		
		## color rect
		color_rect.color = Color("FFFF00")
		color_rect.set_size(Vector2(40,40))
		color_rect.global_position = orb.global_position - (color_rect.size / 2)

		
		## cpøøosopm shape
		var rectangle_shape = RectangleShape2D.new()
		rectangle_shape.size = color_rect.size
		collision_shape.set_shape(rectangle_shape)

		collision_shape.global_position=orb.global_position-(color_rect.size / 2)

	
		
		area.add_child(collision_shape)
		$orbs.add_child(color_rect)
		$orbs.add_child(area)
