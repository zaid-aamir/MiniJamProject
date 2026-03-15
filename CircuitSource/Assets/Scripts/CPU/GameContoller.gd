class_name SceneManagerNode extends Node

@onready var Game2D: Node = $World2D
var MainScene2D: Node
var MainScene2DPath: String

func Die(): Change2DScene("res://Scenes/DeathScreen.tscn")

func _ready() -> void:
	Change2DScene("res://Scenes/Game.tscn")

func Change2DScene(Scene:String = MainScene2DPath,Delete: bool = true) -> Node:
	if MainScene2D:
		if Delete: MainScene2D.queue_free()
		else: MainScene2D.hide()
	var NewScene:Node = load(Scene).instantiate()
	MainScene2DPath = Scene
	MainScene2D = NewScene
	Game2D.add_child(NewScene)
	return NewScene
