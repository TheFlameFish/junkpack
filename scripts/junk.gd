extends RigidBody2D

@export var type : String

@export var canBePickedUp : bool = false

var collectionArea : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collectionArea = $CollectionArea


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_collection_area_body_entered(body):
	print("Player entered")
	if canBePickedUp:
		var pack = $"../Player/Pack"
		pack.add_junk(type)
		
		queue_free()
