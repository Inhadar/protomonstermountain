extends Control


@export var size_matrix = [
	[0,0,0,1],
	[1,1,1,1]
]
var tile_size = 32

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#check distance
		var distance = event.position.distance_to(position)
		if distance <20:
			print("OBjECT")


func  _ready() -> void:
	enemy_visualition()#<--NO NEED

func enemy_visualition():
	for column in size_matrix.size():
		for row in size_matrix[column].size():
			if size_matrix[column][row] == 1:
				var new_sprite = Sprite2D.new()
				new_sprite.texture = load("res://Sprites/testtileenemy.png")
				add_child(new_sprite)
				new_sprite.global_position += Vector2(tile_size*row,tile_size*column)
				
	
	pass
