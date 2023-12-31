extends Control

@export var COPY_CAM_CONTROLLER: CopyCamController


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(COPY_CAM_CONTROLLER.MAX_PHOTOS):
		self.add_child(create_texture_rect_child(i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_add_photos_frames(photos:Array[CopyObject], max_photos:int):
	# Añadimos de uno en uno, en algun momento el len de photos se pausa y el 
	add_texture_rect(photos)
	
func _on_hide_photos_frames(photos:Array[CopyObject], max_photos:int,photos_count:int):
	reset_texture_rect(max_photos,photos_count)
	add_texture_rect(photos)
	

func add_texture_rect(photos:Array[CopyObject]):
	print(len(photos))
	for i in range(len(photos)):
		var children_texture_rect = self.get_children()[i] as TextureRect
		var load_path = "res://Assets/Images/" + photos[i].get_meta("Object_Name")+"_frame.png"
		children_texture_rect.texture = load(load_path)

func reset_texture_rect(max_photos:int, photos_put_count:int):
	for i in range(max_photos):
		var children_texture_rect = self.get_children()[i] as TextureRect
		var load_path = "res://Assets/Images/CameraFrame.png"
		children_texture_rect.texture = load(load_path)
		if(i >= max_photos-photos_put_count):
			children_texture_rect.modulate = Color("ffffff68")
		
		
func create_texture_rect_child(index: int) -> TextureRect:
	var scene = preload("res://Scenes/Control/photos_frames.tscn")
	var instante = scene.instantiate()
	var node_position = Vector2((index*100)+60,60)
	instante.texture = load("res://Assets/Images/CameraFrame.png")
	instante.position = node_position
	return instante
	



