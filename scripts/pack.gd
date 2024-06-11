extends Node2D

@export var power : float = 5000;

@export var junk = []
@export var junkQuantity = []

var player : RigidBody2D

var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	rng = RandomNumberGenerator.new()


# Called every physics process. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = -player.rotation
	check_inputs()

func check_inputs():
	if Input.is_action_just_pressed("pack_fire"):
		var forceVector = -power * (get_local_mouse_position() - position).normalized()
		
		print("Applying a force of "+str(forceVector)+"N")
		
		player.apply_central_force(forceVector)

func add_junk(junkType : String):
	var junkIndex = junk.find(junkType)
	
	if junkIndex != -1:
		junkQuantity[junkIndex] += 1
	else:
		junk.append(junkType)
		junkQuantity.append(1)
		
	print("Added junk "+junkType)
	print(str(junk))
	print(str(junkQuantity))
		
func remove_junk(junkType : String = junk[rng.randi_range(0,junk.size()-1)]):
	if (junk.size() > 0):
		##junkType = junkType or junk[rng.randi_range(0,junk.size()-1)]
		var junkIndex = junk.find(junkType)
		
		if junkIndex != -1:
			junkQuantity[junkIndex] -= 1
			return true
		else:
			return false
	else:
		return false

	
