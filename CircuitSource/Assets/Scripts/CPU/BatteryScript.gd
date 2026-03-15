class_name Battery extends AnimatedSprite2D

@export var Charge:float = 100

func Animate():
	if Charge > 66: self.animation = "Full"
	elif Charge > 33: self.animation = "Two-Thirds"
	else: self.animation = "One-Third"

func _process(delta: float) -> void:
	Animate()
	if Charge <= 0:
		self.queue_free()
