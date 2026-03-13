class_name DropArea extends Area2D

var PlayerThatWillPickUp: Player = null
var IsPlayerThere:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func GetObject() -> Node2D:
	return PlayerThatWillPickUp.PickedUpItem

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and PlayerThatWillPickUp:
		PlayerThatWillPickUp.RemoveItem()


func _on_body_entered(body: Node2D) -> void:
	print("Love")
	if body is Player: 
		PlayerThatWillPickUp = body
		IsPlayerThere = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player: 
		PlayerThatWillPickUp = null
		IsPlayerThere = false
