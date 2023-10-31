extends Node3D


@export var Marker: Marker3D
@export var CAMERA_RAYCAST : RayCast3D
@export var FLASH_PARTICLES : GPUParticles3D

var _item_selection_num : int = 0
var _selection_mode : bool = false

var photos_taken: Array[CopyObject] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	
	if event.is_action_pressed("action_2"):
		#Poner el bloque
		if _selection_mode:
			if len(photos_taken) > 0  and photos_taken[_item_selection_num].mesh_transparency_enabled:
				photos_taken[_item_selection_num].object_release()
				print(photos_taken[_item_selection_num].get_meta("Object_Name"))
				photos_taken[_item_selection_num].reparent(self.owner.get_parent())
				photos_taken.remove_at(_item_selection_num)
				_item_selection_num = 0
			_selection_mode = false	
		
		elif len(photos_taken) > 0:
			object_selection()
			
		print(_selection_mode)
			
	
	if event.is_action_pressed("action_1"):
		# Tirar foto
		FLASH_PARTICLES.emitting = true
		if CAMERA_RAYCAST.is_colliding():
			var object_to_copy = CAMERA_RAYCAST.get_collider() as CopyObject
			if object_to_copy:
				#TO DO: Change the duplicate() someday.
				print("FLASH")
				photos_taken.append(object_to_copy.duplicate())
	
	if event.is_action_pressed("inventory_right"):
		if len(photos_taken) > 0:
			if _selection_mode:
				object_deslection()
			_item_selection_num = (_item_selection_num + 1)%len(photos_taken)
		

	if event.is_action_pressed("ui_up"):
		print(photos_taken)

func object_deslection():
	Marker.remove_child(photos_taken[_item_selection_num])
	
	_selection_mode = false

func object_selection():
	photos_taken[_item_selection_num].object_picked()
	Marker.add_child(photos_taken[_item_selection_num])
	_selection_mode = true