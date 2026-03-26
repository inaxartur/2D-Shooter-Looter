extends Timer

@onready var shootTimer : Timer = $"."

func _on_timeout() -> void:
	print("shootTImers")
	SignalBus.shootTimerEnded.emit()
	shootTimer.stop()
