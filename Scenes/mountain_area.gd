extends Node2D


var rows = 8
var columns =8
var rect_size = 32

var in_inventory = false
var tile_list = {}

@onready var tile = preload("res://Objects/tile.tscn")



func _ready() -> void:
	make_matrix()


func get_grid_position(mouse_pos: Vector2) -> Vector2i:
	var cell_size = Vector2(rect_size,rect_size)
	var grid_x = floor(mouse_pos.x / cell_size.x)
	var grid_y = floor(mouse_pos.y / cell_size.y)
	return Vector2i(grid_x, grid_y)



func make_matrix():
	var offset = (get_viewport_rect().size-Vector2(rows*rect_size,columns*rect_size))/2
	global_position = offset
	#position.y = (get_viewport_rect().size.y-(columns*rect_size))-128
	var shape = RectangleShape2D.new()
	shape.size = Vector2(rows*rect_size,columns*rect_size)
	$CollisionShape2D.set_shape(shape)
	
	$CollisionShape2D.global_position.y += (columns*rect_size)/2+rect_size/2
	$CollisionShape2D.global_position.x += (rows*rect_size)/2+rect_size/2
	#$CollisionShape2D.position.x -=rect_size/2
	#$CollisionShape2D.position.y -=rect_size/2

	for y in columns:
		tile_list[y] = {}
		for x in rows:
			tile_list[y][x] ={}
			var new_tile = tile.instantiate()
			%Tiles.add_child(new_tile)
			
			new_tile.global_position = global_position +  Vector2(rect_size*x,rect_size*(columns-y))
			#new_tile.global_position.y -= rect_size*columns
			new_tile.get_node(NodePath("Label")).text = str(x,",",y)
			await  get_tree().create_timer(0.1).timeout


func _physics_process(delta: float) -> void:
	move_cursor_to_mouse()
	
	
func move_cursor_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var snapped_pos = mouse_pos.snapped(Vector2(rect_size, rect_size))
	
	var offset = (get_viewport_rect().size-Vector2(rows*rect_size,columns*rect_size))/2
	var local_mouse_pos = mouse_pos - offset
	print(get_grid_position(offset))
	$Cursor.global_position = local_mouse_pos



func _on_mouse_entered() -> void:
	in_inventory = true


func _on_mouse_exited() -> void:
	in_inventory = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player.modulate.a = 0.5


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player.modulate.a = 1
