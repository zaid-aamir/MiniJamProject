class_name SceneManagerNode extends Node

@onready var Game2D: Node = $World2D
var MainScene2D: Node2D
var MainScene2DPath: String

@onready var GUI: Node = $GUI
var GUIMainScene: Control
var GUIMainScenePath: String

func Die(): Change2DScene("res://Scenes/Game.tscn")

func _ready() -> void:
	Change2DScene("res://Scenes/Game.tscn")

func Change2DScene(Scene:String = MainScene2DPath,Delete: bool = true) -> Node2D:
	if MainScene2D:
		if Delete: MainScene2D.queue_free()
		else: MainScene2D.hide()
	var NewScene:Node2D = load(Scene).instantiate()
	MainScene2DPath = Scene
	MainScene2D = NewScene
	Game2D.add_child(NewScene)
	return NewScene

func ChangeGUIScene(Scene:String = GUIMainScenePath,Delete: bool = true) -> Control:
	if GUIMainScene:
		if Delete: GUIMainScene.queue_free()
		else: GUIMainScene.hide()
	var NewScene:Control
	NewScene = load(Scene).instantiate()
	GUIMainScenePath = Scene
	GUIMainScene = NewScene
	GUI.add_child(NewScene)
	return NewScene
