extends Area2D

# Envanter alanı (örnek: 10x10 hücre)
var grid_position = Vector2(320,256)#<---offset
var rows = 10
var columns = 10
var cell_size = Vector2(32, 32)
var grid_size = Vector2()
var grid_data = []
@onready var tile_scene = preload("res://Objects/tile.tscn")

var item := {
	"size": Vector2i(2, 2),
	"position": Vector2i(0,0)
	}
func _ready() -> void:
	init_grid()
	
	var place_pos := Vector2i(3, 3)


	if can_place_item_at(item, place_pos):
		place_item(item, place_pos)
		print("Item placed at: ", place_pos)
	else:
		print("Can't place item at: ", place_pos)
	
	var offset = (get_viewport_rect().size-Vector2(rows*cell_size.x,columns*cell_size.y))/2
	grid_position = offset
	grid_size = Vector2(cell_size.x*rows,cell_size.x*columns)
	make_inventory()


func _physics_process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	move_cursor_to_mouse()
	
func make_inventory():
	var new_color_rect = ColorRect.new()
	add_child(new_color_rect)
	new_color_rect.size = grid_size
	new_color_rect.color = Color.BLACK
	new_color_rect.position =grid_position

	for x in rows:
		for y in columns:
			var new_cell= tile_scene.instantiate()
			new_color_rect.add_child(new_cell)
			new_cell.get_node(NodePath("Label")).text = str(x,",",y)
			new_cell.global_position =new_color_rect.global_position+ Vector2(cell_size.x*x,cell_size.y*y)

func move_cursor_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var local_mouse = mouse_pos - grid_position
	var grid_index = local_mouse / cell_size
	var cell_coords = (local_mouse / cell_size).floor()
	var snapped_pos = cell_coords * cell_size + grid_position
	$Cursor.global_position = snapped_pos
	$Label.text = str((grid_index).floor())

func init_grid():
	grid_data.clear()
	for y in columns:
		var row := []
		for x in rows:
			row.append(false) # false = boş hücre
		grid_data.append(row)

func can_place_item_at(item: Dictionary, pos: Vector2i) -> bool:
	for y in range(item["size"].y):
		for x in range(item["size"].x):
			var gx = pos.x + x
			var gy = pos.y + y
			if gx >= columns or gy >= rows:
				return false
			if grid_data[gy][gx]:
				return false
	return true

func place_item(item: Dictionary, pos: Vector2i) -> void:
	for y in range(item["size"].y):
		for x in range(item["size"].x):
			var gx = pos.x + x
			var gy = pos.y + y
			grid_data[gy][gx] = true
	item["position"] = pos
