extends Node2D


var enemy_type = {
	"tiny": Vector2(1,1),
	"small": Vector2(1,1),
	"medium": Vector2(1,1),
	"big": Vector2(1,1),
	"huge": Vector2(1,1),
	"giant": Vector2(1,1),
	"mega": Vector2(1,1),
	"giga": Vector2(1,1),
	"titan": Vector2(1,1)
}

var enemy_frames = {
	"tiny": 0,
	"small": 1,
	"medium": 2,
	"big": 3,
	"huge": 4,
	"giant": 5,
	"mega": 6,
	"giga": 7,
	"titan":8,
}

var curren_item_size = "tiny"
func set_item_sprites():
	$Sprite2D.frame = enemy_frames[curren_item_size]
	
var swipe_speed = 10

func _physics_process(delta: float) -> void:
	var target_pos = Vector2.ZERO
	var distance = global_position.distance_to(target_pos)
	if Input.is_action_pressed("MouseLeft"):
		target_pos = get_global_mouse_position()
	if distance <100:
		global_position = lerp(global_position,target_pos,delta*swipe_speed)
