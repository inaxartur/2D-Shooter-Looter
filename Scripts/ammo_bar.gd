extends ProgressBar

@onready var ammoBar : ProgressBar = $"."

func _ready() -> void:
	SignalBus.weaponReloaded.connect(_on_weapon_reloaded)
	SignalBus.weaponShoot.connect(_on_weapon_shoot)
	SignalBus.weaponMagCapacity.connect(_on_weapon_ready_set_mag_capacity)

func manipulateValue(value: int) -> void:
	ammoBar.value += value

func _on_weapon_shoot() -> void:
	manipulateValue(-1)

func _on_weapon_reloaded(magCapacity : int) -> void:
	manipulateValue(magCapacity)

func _on_weapon_ready_set_mag_capacity(magCapacity : int) -> void:
	ammoBar.max_value = magCapacity
	ammoBar.value = magCapacity
