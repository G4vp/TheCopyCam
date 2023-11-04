class_name CopyCamController
extends Node3D

signal add_photos_frames(photos:Array, max_photos:int)
signal hide_photos_frames(photos:Array, max_photos:int, photos_put_count:int)

@export var Marker: Marker3D
@export var CAMERA_RAYCAST : RayCast3D
@export var WHITE_PARTICLES : GPUParticles3D
@export var RED_PARTICLES : GPUParticles3D

var MAX_PHOTOS: int
var PHOTOS_COUNT: int = 0
var PHOTOS_PUT_COUNT : int = 0

var _item_selection_num : int = 0
var _selection_mode : bool = false


var photos_taken: Array[CopyObject] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_PHOTOS = (self.owner as Player).MAX_PHOTOS


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
				PHOTOS_PUT_COUNT += 1
				hide_photos_frames.emit(photos_taken,MAX_PHOTOS,PHOTOS_PUT_COUNT)
			_selection_mode = false	
		
		elif len(photos_taken) > 0:
			object_selection()
			
		print(_selection_mode)
			
	
	if event.is_action_pressed("action_1"):
		# Tirar foto
		if _selection_mode:
			object_deslection()
		elif CAMERA_RAYCAST.is_colliding():
			var object_to_copy = CAMERA_RAYCAST.get_collider() as CopyObject
			
			if object_to_copy:
				if PHOTOS_COUNT < MAX_PHOTOS:
					PHOTOS_COUNT += 1
					WHITE_PARTICLES.emitting = true
					photos_taken.append(object_to_copy.duplicate())
					add_photos_frames.emit(photos_taken, MAX_PHOTOS)
				else:
					RED_PARTICLES.emitting = true
	
	#if event.is_action_pressed("inventory_right"):
	#	if len(photos_taken) > 0:
	#		if _selection_mode:
	#			object_deslection()
	#		_item_selection_num = (_item_selection_num + 1)%len(photos_taken)
		

	if event.is_action_pressed("ui_up"):
		print(photos_taken)

func object_deslection():
	Marker.remove_child(photos_taken[_item_selection_num])
	_selection_mode = false

func object_selection():
	photos_taken[_item_selection_num].object_picked()
	Marker.add_child(photos_taken[_item_selection_num])
	_selection_mode = true
