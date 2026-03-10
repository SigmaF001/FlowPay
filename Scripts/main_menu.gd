extends Control

var COLLECTION_ID = "player_data"

@onready var selectButton : NinePatchRect = $"Select Panel"
@onready var savingTable : Control = $"Saving Table"
@onready var ledger : Control = $Ledger
@onready var username_display : Label = $"Select Panel/Label"

var petting_count: int = 0:
	set(value):
		petting_count = value
		$"Select Button/PettingCountLabel".text = str(value)

func _ready() -> void:
	selectButton.visible = true
	savingTable.visible = false
	ledger.visible = false

func _process(delta: float) -> void:
	username_display.text = "Account : %s" % [GlobalManager.username]

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

func _on_save_button_pressed() -> void:
	save_data()

func _on_logout_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Scenes/user_auth.tscn")


func save_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var username = GlobalManager.username
		var data: Dictionary = {
			"username": username,
			"petting_count": petting_count
		}
		var doc: FirestoreDocument = await collection.add(auth.localid, data)
		if doc is FirestoreDocument:
			print("Success!")
		else:
			print("Something went wrong with the Firebase request.")

func _on_save_finished(data):
	print("Data saved successfully!")

func _on_save_error(code, status, message):
	print("Save failed: ", message)
