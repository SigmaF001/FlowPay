extends Node

@export var AuthPanel : Control
@export var MainMenuPanel : Control

func _ready() -> void:
	OnStartScene()

func OnStartScene():
	AuthPanel.visible = true
	MainMenuPanel.visible = false

func OnLoginSucsess():
	AuthPanel.visible = false
	MainMenuPanel.visible = true
	print("Login success!")
