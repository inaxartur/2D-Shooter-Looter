extends Node2D

var WhoPickedUp : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WhoPickedUp = get_parent()
	print(WhoPickedUp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#global_position = WhoPickedUp.global_position
	pass
