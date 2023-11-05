extends Node3D

@export var node_to_rotate: Node3D
@export var gui_controls : Control

@export var title:Label
@export var play_button: Button
@export var quit_button: Button
@export var controls_button: Button
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	MusicController.play_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	node_to_rotate.rotate_y((PI/6) * delta)


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Environment/Level1.tscn")
	MusicController.play_in_game()


func _on_quit_pressed():
	get_tree().quit()

func _on_controls_pressed():
	play_button.hide()
	quit_button.hide()
	controls_button.hide()
	title.hide()
	gui_controls.show()
	
func _on_continue_controls_pressed():
	play_button.show()
	quit_button.show()
	controls_button.show()
	title.show()
	gui_controls.hide()


