extends Control

@export var Sprite:AnimatedSprite2D
@export var DeathMenuTime: float

var TimeUntilClose: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TimeUntilClose += delta
	if TimeUntilClose >= DeathMenuTime: SceneManagment.Change2DScene("res://Scenes/Game.tscn")
