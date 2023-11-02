extends Control

@export var COPY_CAM_CONTROLLER: CopyCamController


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_add_photos_frames(photos:Array[CopyObject], max_photos:int):
	# Añadimos de uno en uno, en algun momento el len de photos se pausa y el 
	if self.get_child_count() == 0:
		for i in range(max_photos):
			self.add_child(create_texture_rect_child(i))
	print(photos)
	add_texture_rect(photos)
	
func _on_hide_photos_frames(photos:Array[CopyObject], max_photos:int):
	reset_texture_rect(photos.size(),max_photos)
	add_texture_rect(photos)

func add_texture_rect(photos:Array[CopyObject]):
	for i in range(len(photos)):
		var children_texture_rect = self.get_children()[i] as TextureRect
		var load_path = "res://Assets/Images/" + photos[i].get_meta("Object_Name")+"_frame.png"
		children_texture_rect.texture = load(load_path)

func reset_texture_rect(photos_size:int,max_photos:int):
	for i in range(photos_size,max_photos):
		var children_texture_rect = self.get_children()[i] as TextureRect
		var load_path = "res://Assets/Images/CameraFrame.png"
		children_texture_rect.texture = load(load_path)
		
func create_texture_rect_child(index: int) -> TextureRect:
	var scene = preload("res://Scenes/Control/photos_frames.tscn")
	var instante = scene.instantiate()
	var node_position = Vector2(index*100+(get_viewport().size.x/40),get_viewport().size.y/60)

	instante.texture = load("res://Assets/Images/CameraFrame.png")
	instante.position = node_position
	return instante
	



