extends Control

@export var GlobalControl : Node

var username = ""
var email = ""
var password
var confirmPassword

@export var loginPanel : Control
@export var registerPanel : Control

func _ready() -> void:
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	loginPanel.visible = true
	registerPanel.visible = false
	
func _process(delta: float) -> void:
	pass

func TestLogin():
	username = $"Login Menu/Username"
	password = $"Login Menu/Password"
	
	if(username != null or username != "" and
		password != null or password != ""):
		$"Login Menu".visible = false
		GlobalControl.OnLoginSucsess()

func _on_login_button_pressed() -> void:
	var email = $"Login Menu/Email Input".text
	var password = $"Login Menu/Password Input".text
	Firebase.Auth.login_with_email_and_password(email, password)


func _on_register_menu_button_pressed() -> void:
	loginPanel.visible = false
	registerPanel.visible = true


func _on_register_button_pressed() -> void:
	var username = $"Register Menu/Username".text
	var email = $"Register Menu/Email".text
	var password = $"Register Menu/Password".text
	var confirm_password = $"Register Menu/ConfirmPassword".text
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_login_menu_button_pressed() -> void:
	loginPanel.visible = true
	registerPanel.visible = false

func on_login_succeeded(auth):
	print(auth)

func on_signup_succeeded(auth):
	print(auth)

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$"Login Menu/Login State Label".text = "Login failed. Error: %s" % message
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$"Register Menu/Register State Label".text = "Register failed. Error: %s" % message
