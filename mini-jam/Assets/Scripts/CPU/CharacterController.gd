class_name Player extends CharacterBody2D

@export var JumpPower: float
@export var UpResistance:float
@export var FallPower: float
@export var MovePower: float
@export var MoveFriction: float
@export var StopFriction: float
@export var VelocityYWhenFalling:float
@export var CoyoteTimeSeconds: float
@export var JumpBufferSeconds: float

var Direction:float = 0
var Floating:bool = false
var TimeUntilNotJumpAble: float = 0
var TimeUntilBufferNotUsed:float = 0

func ApplyGravity():
	if Floating: velocity.y += UpResistance
	else: velocity.y += FallPower

func ApplyFriction():
	if Direction: velocity.x *= MoveFriction
	else: velocity.x *= StopFriction

func CheckIfFloating():
	if Floating: Floating = velocity.y < VelocityYWhenFalling 

func DecreaseTimeOnBuffers(delta: float):
	TimeUntilNotJumpAble -= delta
	TimeUntilBufferNotUsed -= delta

func CheckIfJumpAble():
	if is_on_floor(): TimeUntilNotJumpAble = CoyoteTimeSeconds

func IsJumping(): return TimeUntilBufferNotUsed > 0

func Jump():
	TimeUntilNotJumpAble = 0
	TimeUntilBufferNotUsed = 0
	velocity.y = JumpPower
	Floating = true

func OnJumpInput():
	TimeUntilBufferNotUsed = JumpBufferSeconds

func JumpAble(): return TimeUntilNotJumpAble > 0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	Direction = Input.get_axis("MoveLeft","MoveRight")
	DecreaseTimeOnBuffers(delta)
	if Input.is_action_just_pressed("Jump"): OnJumpInput()
	if IsJumping() and JumpAble(): Jump()
	CheckIfFloating()
	CheckIfJumpAble()
	
func _physics_process(delta: float) -> void:
	velocity.x += MovePower * Direction
	ApplyFriction()
	ApplyGravity()
	move_and_slide()
