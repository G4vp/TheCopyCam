extends Control

@onready var _pause_control = $PauseControl
@onready var _isPause: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	
	if event.is_action_pressed("pause"):
		if _isPause:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			_pause_control.hide()
			_isPause = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			_pause_control.show()
			_isPause = true

func _on_quit_button_pressed():
	get_tree().quit()


func _on_continue_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_pause_control.hide()
	_isPause = false
