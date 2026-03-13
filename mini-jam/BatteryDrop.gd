extends Node

@export var Parent: DropArea

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and Parent.IsPlayerThere:
		Parent.GetObject().queue_free()
	print(Parent.PlayerThatWillPickUp)
