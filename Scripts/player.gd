extends CharacterBody2D

### debug
@export var isDebug : bool = false
var debugIter : int = 0

### export
@export var inHandItem : PackedScene # still in implementation

### onready
@onready var SpriteAnimator : AnimatedSprite2D = $AnimatedSprite2D

### var
var directionHorizontal : float
var directionVertical : float

## TEMPORARY TO CHANGE
var isItemInHand : bool = false
var isInteractionPossible : bool = false
var currentArea2DInRange : Area2D = null
var mp9
var itemInHand : Node2D

## const
const SPEED := 100.0


func _physics_process(delta: float) -> void:
	playerMoveInput()
	move_and_slide()
	playerInputInteraction()
	interactionPossible()
	
	if(isDebug):
		debug()

func playerMoveInput() -> void:
	directionHorizontal = Input.get_axis("m_left", "m_right")
	directionVertical = Input.get_axis("m_up", "m_down")
	if directionHorizontal || directionVertical:
		velocity.x = directionHorizontal * SPEED
		velocity.y = directionVertical * SPEED
		SpriteAnimator.play("Walk")
		if(directionHorizontal > 0 && SpriteAnimator.flip_h == false):
			SpriteAnimator.flip_h = true
		elif(directionHorizontal < 0 && SpriteAnimator.flip_h == true):
			SpriteAnimator.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		SpriteAnimator.play("Idle")

func playerInputInteraction() -> void:
	if(Input.is_action_just_pressed("drop_item") && isItemInHand):
		itemInHand.drop()
		itemInHand.free()
		isItemInHand = false
		print("Dropping itema")
		

func interactionPossible() -> void:
	if(isInteractionPossible):
		print("interatction possible")
		pickupItem()

func inHandItemSetter(item: Lying_Item) -> void:
	item = Lying_Item.new()
	item.getItem()

func debug() -> void:
	debugIter += 1
	if(debugIter > 4):
		print("Player pos: ", position)
		print("direcHor: ", directionHorizontal)
		print("direcVer: ", directionVertical)
		debugIter = 0

func pickupItem() -> void:
	if (currentArea2DInRange.has_method("getItem") && Input.is_action_pressed("interact")):
		mp9 = currentArea2DInRange.getItem().instantiate()
		add_child(mp9)
		mp9.position = Vector2.DOWN
		currentArea2DInRange.free()
		itemInHand = mp9
		isItemInHand = true
		isInteractionPossible = false
		currentArea2DInRange = null

func _on_pickup_area_area_entered(area: Area2D) -> void:
	isInteractionPossible = true
	currentArea2DInRange = area


func _on_pickup_area_area_exited(area: Area2D) -> void:
	isInteractionPossible = false
	currentArea2DInRange = null
