class_name SceneManagerNode extends Node

@onready var Game2D: Node = $World2D
var MainScene2D: Node2D
var MainScene2DPath: String

@onready var GUI: Node = $GUI
var GUIMainScene: Control
var GUIMainScenePath: String

func _ready() -> void:
	Change2DScene("res://Scenes/Game.tscn")

func Change2DScene(Scene:String = MainScene2DPath,Delete: bool = true) -> void:
	if MainScene2D:
		if Delete: MainScene2D.queue_free()
		else: MainScene2D.hide()
	var NewScene = load(Scene).instantiate()
	MainScene2DPath = Scene
	MainScene2D = NewScene
	Game2D.add_child(NewScene)

func ChangeGUIScene(Scene:String = GUIMainScenePath,Delete: bool = true) -> void:
	if GUIMainScene:
		if Delete: GUIMainScene.queue_free()
		else: GUIMainScene.hide()
	var NewScene:Node
	NewScene = load(Scene).instantiate()
	GUIMainScenePath = Scene
	GUIMainScene = NewScene
	GUI.add_child(NewScene)
	print_tree_pretty()
