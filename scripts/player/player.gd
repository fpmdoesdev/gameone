extends CharacterBody2D

@export var speed: float = 300.0
@export var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var fire_rate: float = 0.15

@onready var muzzle: Marker2D = $Muzzle

var can_shoot: bool = true

func _physics_process(_delta: float) -> void:
	# 1. Aim toward the mouse cursor
	look_at(get_global_mouse_position())

	# 2. Get directional input (WASD or Arrow keys)
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# 3. Calculate velocity and move
	velocity = direction * speed
	move_and_slide()
	
	if(Input.is_action_pressed("shoot") and can_shoot):
		shoot()
	
func shoot():
	if(!bullet_scene):
		return
	
	can_shoot = false
	
	var bullet := bullet_scene.instantiate() as Node2D
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	
	get_tree().current_scene.add_child(bullet)
	
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
