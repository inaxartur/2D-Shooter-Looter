extends Timer

@onready var shootTimer : Timer = $"."

func _on_timeout() -> void:
	SignalBus.shootTimerEnded.emit()
	shootTimer.stop()
