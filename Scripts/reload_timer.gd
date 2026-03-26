extends Timer

@onready var reloadTimer : Timer = $"."

func _on_timeout() -> void:
	SignalBus.reloadTimerEnded.emit()
	reloadTimer.stop()
