extends CharacterBody2D

@export var isDebug : bool = false
@export var inHandItem : Node2D
var debugIter : int = 0

var directionHorizontal : float
var directionVertical : float

const SPEED := 100.0


func _physics_process(delta: float) -> void:
	directionHorizontal = Input.get_axis("m_left", "m_right")
	directionVertical = Input.get_axis("m_up", "m_down")
	if directionHorizontal || directionVertical:
		velocity.x = directionHorizontal * SPEED
		velocity.y = directionVertical * SPEED
		$AnimatedSprite2D.play("Walk")
		if(directionHorizontal > 0 && $AnimatedSprite2D.flip_h == false):
			$AnimatedSprite2D.flip_h = true
		elif(directionHorizontal < 0 && $AnimatedSprite2D.flip_h == true):
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("Idle")
	
	move_and_slide()
	
	if(isDebug):
		debug()


func debug() -> void:
	debugIter += 1
	if(debugIter > 4):
		print("Player pos: ", position)
		print("direcHor: ", directionHorizontal)
		print("direcVer: ", directionVertical)
		debugIter = 0
