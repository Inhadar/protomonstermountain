extends CharacterBody2D

var jump_force = 60000
var speed = 20000
var axis = Vector2()
var gravity = 90

var current_enemy = null

var enemy_picked = false



func _physics_process(delta: float) -> void:
	
	if enemy_picked:
		current_enemy.global_position = $Marker2D.global_position
	
		
	if current_enemy != null:
		if Input.is_action_just_pressed("pick"):
			if enemy_picked ==false:
					
				enemy_picked = true
				if current_enemy.rotation_degrees != 90:
					current_enemy.rotation_degrees = 90
				current_enemy.global_position = $Marker2D.global_position
			else:
				enemy_picked = false
				current_enemy.global_position = global_position
				
		
	var dir = Input.get_action_strength("Right") -Input.get_action_strength("Left")
	axis.x= dir
	
	if !is_on_floor():
		velocity.y+=gravity
	
	if Input.is_action_just_pressed("jump"):
		velocity.y -= jump_force*delta
	
	velocity.x = axis.x*speed*delta
	move_and_slide()


func _on_contact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		current_enemy = body
		#pick enemy
		#change current enemy value
		pass
	


func _on_contact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		current_enemy = null

		pass
	
