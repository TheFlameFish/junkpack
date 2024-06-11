extends Node2D

@export var power : float = 100;

@export var junk = []
@export var junkQuantity = []

var player : RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."


# Called every physics process. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = -player.rotation
	check_inputs()

func check_inputs():
	if Input.is_action_pressed("pack_fire"):
		var forceVector = -power * (get_local_mouse_position() - position).normalized()
		
		print("Applying a force of "+str(forceVector)+"N")
		
		player.apply_central_force(forceVector)
