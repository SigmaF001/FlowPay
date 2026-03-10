extends Node

var COLLECTION_ID = "player_data"
@export var username = ""

var petting_count: int = 0:
	set(value):
		petting_count = value

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

func load_data(user_id):
	var collection = Firebase.Firestore.collection("player_data")
	var document = await collection.get_doc(user_id)
	if document and document.document:
		var data = document.document
		GlobalManager.username = get_firebase_value(data.get("username", {}))
		GlobalManager.petting_count = get_firebase_value(data.get("petting_count", {}))
		
		print("Data Loaded: ", GlobalManager.username)
	else:
		print("Document exists but contains no data fields.")

func get_firebase_value(field_data: Dictionary):
	if field_data.has("stringValue"):
		return field_data["stringValue"]
	if field_data.has("integerValue"):
		return field_data["integerValue"]
	if field_data.has("doubleValue"):
		return field_data["doubleValue"]
	if field_data.has("booleanValue"):
		return field_data["booleanValue"]
	return null
