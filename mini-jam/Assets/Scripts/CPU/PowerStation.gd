extends Node2D

@export var ParentBatteryPlug: BatteryPlug
@export var Power: float = 0
@export var Switch: Area2D
@export var SwitchSprite: AnimatedSprite2D
@export var Screen: AnimatedSprite2D

var PlayerAbleToInteract:bool
var SwitchOn:bool = false

func Animate() -> void:
	if SwitchOn: SwitchSprite.animation = "On"
	else: SwitchSprite.animation = "Off"

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	Animate()
	if Input.is_action_just_pressed("Interact") and PlayerAbleToInteract: 
		SwitchOn = not SwitchOn

func _on_switch_body_entered(body: Node2D) -> void:
	if body is Player: PlayerAbleToInteract = true 



func _on_switch_body_exited(body: Node2D) -> void:
	if body is Player: PlayerAbleToInteract = false
