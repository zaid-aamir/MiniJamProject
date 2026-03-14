extends Node2D

@export var ParentBatteryPlug: BatteryPlug
@export var PowerUsage: float
@export var Switch: Area2D
@export var SwitchSprite: AnimatedSprite2D
@export var Screen: AnimatedSprite2D
@export var ResponseTime:float
@export var MinTimeToWaitToNeedCharge: int
@export var MaxTimeToWaitToNeedCharge: int

var NeedPower: bool = false
var PlayerAbleToInteract:bool = false
var SwitchOn:bool = false
var Waiting: bool = false
var PowerTimer: float

func SetPowerUsage():
	if AbleToUsePower(): ParentBatteryPlug.ChargeDecrease = PowerUsage
	else: ParentBatteryPlug.ChargeDecrease = 0
	
func SwitchAnimate() -> void:
	if not ParentBatteryPlug.StoredItem: SwitchOn = false
	if SwitchOn: SwitchSprite.animation = "On"
	else: SwitchSprite.animation = "Off"

func ScreenAnimate() -> void:
	if NeedPower and not AbleToUsePower(): Screen.animation = "LowPower"
	elif AbleToUsePower() and NeedPower: Screen.animation = "UsingPower"
	elif AbleToUsePower() and not NeedPower: Screen.animation = "WastingPower"
	else: Screen.animation = "Idle"

func _ready() -> void:
	MakePowerUsage()

func AbleToUsePower():
	return SwitchOn and ParentBatteryPlug.StoredItem

func MakePowerUsage() -> void:
	Waiting = false
	await get_tree().create_timer(randi_range(MinTimeToWaitToNeedCharge, MaxTimeToWaitToNeedCharge)).timeout
	OnNeedPower()
	Waiting = true

func _process(delta: float) -> void:
	if Waiting and not NeedPower: MakePowerUsage()
	if NeedPower:
		PowerTimer += delta
		if PowerTimer >= ResponseTime and not AbleToUsePower(): SceneManagement.Die()
		if AbleToUsePower(): WaitThenChangePowerNeed()
	SwitchAnimate()
	ScreenAnimate()
	SetPowerUsage()
	if Input.is_action_just_pressed("Interact") and PlayerAbleToInteract: 
		SwitchOn = not SwitchOn
		
func OnNeedPower():
	NeedPower = true
	PowerTimer = 0
	
func WaitThenChangePowerNeed() -> void:
	await get_tree().create_timer(5).timeout
	NeedPower = false

func _on_switch_body_entered(body: Node2D) -> void:
	if body is Player: PlayerAbleToInteract = true 

func _on_switch_body_exited(body: Node2D) -> void:
	if body is Player: PlayerAbleToInteract = false
