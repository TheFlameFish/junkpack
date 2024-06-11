extends Node2D

@export var power : float = 10000;

@export var junk = ["hairdryer"]
@export var junkQuantity = [1]

var totalJunk : int = 1

var player : RigidBody2D

var rng

var hairdryer = preload("res://scenes/junk_hairdryer.tscn")
var placeholder = preload("res://scenes/junk_placeholder.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	rng = RandomNumberGenerator.new()


# Called every physics process. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = -player.rotation
	check_inputs()

func check_inputs():
	if Input.is_action_just_pressed("pack_fire") && totalJunk > 0:
		var junk_launched = remove_junk() ## I'm now realizing that calling it junk was a bad choice.
		
		var forceVector = -power * (get_local_mouse_position() - position).normalized()
		
		launch_junk(junk_launched,-forceVector)
		
		print("Applying a force of "+str(forceVector)+"N")
		
		player.apply_central_force(forceVector)

func add_junk(junkType : String):
	var junkIndex = junk.find(junkType)
	
	if junkIndex != -1:
		junkQuantity[junkIndex] += 1
	else:
		junk.append(junkType)
		junkQuantity.append(1)
	
	totalJunk += 1
	
	print("Added junk "+junkType)
	print(str(junk))
	print(str(junkQuantity))
	print(totalJunk)
		
func remove_junk(junkType : String = junk[rng.randi_range(0,junk.size()-1)]):
	if (junk.size() > 0):
		##junkType = junkType or junk[rng.randi_range(0,junk.size()-1)]
		var junkIndex = junk.find(junkType)
		
		if junkIndex != -1:
			junkQuantity[junkIndex] -= 1
			
			if junkQuantity[junkIndex] <= 0:
				junk.remove_at(junkIndex)
				junkQuantity.remove_at(junkIndex)
			
			totalJunk -= 1
			return junkType
		else:
			return null
	else:
		return null

func launch_junk(type,vector):
	var launchedJunk : RigidBody2D
	if type == "hairdryer":
		launchedJunk = hairdryer.instantiate()
	else:
		launchedJunk = placeholder.instantiate()

	launchedJunk.canBePickedUp = false
	
	launchedJunk.set_collision_layer_value(1,false)
	launchedJunk.set_collision_mask_value(2,false)
	
	get_tree().root.add_child(launchedJunk)
	launchedJunk.global_position = global_position
	
	launchedJunk.apply_central_force(vector)
