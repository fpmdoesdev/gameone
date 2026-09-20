extends Area2D

@export var speed: float = 800.0
@export var lifetime: float = 2.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	body_entered.connect(_on_body_entered) # connect colision logic
	get_tree().create_timer(lifetime).timeout.connect(queue_free) #remove if doesn't hit anything
	
func _physics_process(delta: float):
	position += transform.x * speed * delta
	
# hits a body -> remove bullet
func _on_body_entered(_body: Node2D):
	queue_free()
