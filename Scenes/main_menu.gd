extends Control

@onready var selectButton : NinePatchRect = $"Select Button"
@onready var savingTable : Control = $"Saving Table"
@onready var ledger : Control = $Ledger

func _ready() -> void:
	selectButton.visible = true
	savingTable.visible = false
	ledger.visible = false

func _on_texture_button_pressed() -> void:
	selectButton.visible = false
	savingTable.visible = true


func _on_texture_button_2_pressed() -> void:
	selectButton.visible = false
	ledger.visible = true


func _on_back_button_pressed() -> void:
	ReturnToMainMenu()

func ReturnToMainMenu():
	selectButton.visible = true
	savingTable.visible = false
	ledger.visible = false
