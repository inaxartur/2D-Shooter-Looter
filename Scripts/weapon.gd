extends Node2D
class_name Weapon

@export var thisNode : Node2D
@export var weaponName : String
@export var dmg : int
@export var rpm : int
@export var reloadTime : float
@export var shootTimerTime : float
@export var magCapacity : int
@export var animator : AnimatedSprite2D
@export var reloadTimer : Timer
@export var shootTimer : Timer
@export var barrelPos : Marker2D

var isShooting : bool = false
var isReloading : bool = false
var isMagCapInBarSet : bool = false
var shootButtonClicked : bool = false

var bulletsInMag : int

### READY ###
func _ready() -> void:
	bulletsInMag = magCapacity
	reloadTimer.wait_time = reloadTime
	shootTimer.wait_time = shootTimerTime
	#shootTimer.wait_time = setShootTimerTime()
	SignalBus.reloadTimerEnded.connect(_on_reload_timer_end)
	SignalBus.shootTimerEnded.connect(_on_shoot_timer_end)

### INPUT ###
func _input(event: InputEvent) -> void:
	if(!isMagCapInBarSet):
		SignalBus.weaponMagCapacity.emit(magCapacity)
		print("EMIT MAGCAP")
		isMagCapInBarSet = true
	if(event.is_action_pressed("reload")):
		reload()
	if(event.is_action_pressed("shoot")):
		shootButtonClicked = true
	elif(event.is_action_released("shoot")):
		shootButtonClicked = false
	if event is InputEventMouseMotion:
		rotateWeaponToMouse(event.position)

func _process(delta: float) -> void:
	if(shootButtonClicked):
		shoot()

func shoot() -> void:
	if(!isShooting && bulletsInMag > 0 && !isReloading):
		isShooting = true
		shootTimer.start()
		bulletsInMag -= 1
		SignalBus.weaponShoot.emit()
		animator.play("shoot")

func reload() -> void:
	if(!isReloading && !isShooting):
		isReloading = true
		reloadTimer.start()
		animator.play("reload")

func rotateWeaponToMouse(mousePos : Vector2) -> void:
	mousePos.x = mousePos.x - 1920 / 2
	mousePos.y = mousePos.y - 1080 / 2
	thisNode.rotation = (thisNode.position.angle_to(mousePos) - PI/2)
	if (thisNode.position.angle_to(mousePos) > 0 ):
		animator.flip_v = false
	else:
		animator.flip_v = true

func setShootTimerTime() -> float: ## UNUSED
	print(rpm/600)
	return rpm / 6000

func _on_reload_timer_end() -> void:
	bulletsInMag = magCapacity
	SignalBus.weaponReloaded.emit(magCapacity)
	isReloading = false

func _on_shoot_timer_end() -> void:
	animator.stop()
	isShooting = false
