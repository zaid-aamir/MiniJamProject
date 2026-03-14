class_name BatteryPlug extends Area2D

@export var Sprite: AnimatedSprite2D
var ChargeDecrease: float
var PlayerThatWillPickUp: Player = null
var IsPlayerThere:bool = false
@export var StoredItem: Battery
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func GetObject() -> Battery:
	return PlayerThatWillPickUp.PickedUpItem

func Animate() -> void:
	if StoredItem:
		Sprite.animation = "Full"
		StoredItem.position = Vector2(0,-30)
	else: Sprite.animation = "Empty"

func _process(delta: float) -> void:
	Animate()
	if StoredItem: StoredItem.Charge -= delta * ChargeDecrease
	if Input.is_action_just_pressed("Interact") and PlayerThatWillPickUp and StoredItem:
		PlayerThatWillPickUp.PickUp(StoredItem)
		StoredItem = null
	elif Input.is_action_just_pressed("Interact") and PlayerThatWillPickUp and PlayerThatWillPickUp.PickedUpItem and not StoredItem:
		StoredItem = PlayerThatWillPickUp.PickedUpItem
		PlayerThatWillPickUp.remove_child(StoredItem)
		self.add_child(StoredItem)
		PlayerThatWillPickUp.RemoveItem(false)

func _on_body_entered(body: Node2D) -> void:
	if body is Player: 
		PlayerThatWillPickUp = body
		IsPlayerThere = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player: 
		PlayerThatWillPickUp = null
		IsPlayerThere = false
