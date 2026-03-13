class_name Player extends CharacterBody2D

@export var JumpPower: float
@export var UpResistance:float
@export var FallPower: float
@export var TerminalFallVelocity: float
@export var MovePower: float
@export var JumpForwardBoost:float
@export var FloatMovePower:float
@export var MoveFriction: float
@export var StopFriction: float
@export var VelocityYWhenFalling:float
@export var CoyoteTimeSeconds: float
@export var JumpBufferSeconds: float
@export var PickedUpItem: AnimatedSprite2D
@export var Sprite: AnimatedSprite2D

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

func Animate():
	if Direction and is_on_floor(): Sprite.animation = "Walk"
	else: Sprite.animation = "Idle"
	if Direction == 1: Sprite.flip_h = false
	elif Direction == -1: Sprite.flip_h = true

func CheckIfFloating():
	if Floating: Floating = velocity.y < VelocityYWhenFalling

func DecreaseTimeOnBuffers(delta: float):
	TimeUntilNotJumpAble -= delta
	TimeUntilBufferNotUsed -= delta

func CheckIfJumpAble():
	if is_on_floor() and not Floating: TimeUntilNotJumpAble = CoyoteTimeSeconds

func IsJumping(): return TimeUntilBufferNotUsed > 0

func PickUp(Item:Battery): 
	if not PickedUpItem:
		PickedUpItem = Item.duplicate()
		self.add_child(PickedUpItem)
		PickedUpItem.position = Vector2(0,-200)
		Item.queue_free()
	
func RemoveItem(Delete: bool = true):
	if Delete: PickedUpItem.queue_free()
	PickedUpItem = null
func Jump(): 
	velocity.x += JumpForwardBoost * Direction
	TimeUntilNotJumpAble = 0
	TimeUntilBufferNotUsed = 0
	velocity.y = JumpPower
	Floating = true

func OnJumpInput():
	TimeUntilBufferNotUsed = JumpBufferSeconds

func Move():
	if Floating: velocity.x += FloatMovePower * Direction
	else: velocity.x += MovePower * Direction

func JumpAble(): return TimeUntilNotJumpAble > 0

func _process(delta: float) -> void:
	Direction = Input.get_axis("MoveLeft","MoveRight")
	DecreaseTimeOnBuffers(delta)
	if velocity.y > TerminalFallVelocity:velocity.y = TerminalFallVelocity
	if Input.is_action_just_pressed("Jump"): OnJumpInput()
	if IsJumping() and JumpAble(): Jump()
	CheckIfFloating()
	CheckIfJumpAble()
	Animate()
	
func _physics_process(delta: float) -> void:
	Move()
	ApplyFriction()
	ApplyGravity()
	move_and_slide()
