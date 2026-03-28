extends CharacterBody2D

### debug
@export var isDebug : bool = false
var debugIter : int = 0

### export
@export var inHandItem : Node2D # still in implementation

### onready
@onready var SpriteAnimator : AnimatedSprite2D = $AnimatedSprite2D

### var
var directionHorizontal : float
var directionVertical : float

const SPEED := 100.0


func _physics_process(delta: float) -> void:
	playerMoveInput()
	move_and_slide()
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

func debug() -> void:
	debugIter += 1
	if(debugIter > 4):
		print("Player pos: ", position)
		print("direcHor: ", directionHorizontal)
		print("direcVer: ", directionVertical)
		debugIter = 0
