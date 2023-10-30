class_name CopyObject

extends RigidBody3D

var CAN_BE_COPY = true
var mesh_transparency_enabled: bool = false

@onready
var normal_mesh = $Normal

@onready
var transparency_mesh = $MeshTransparency

@onready

var collision = $CollisionShape3D

func setPosition(node:Node3D):
	position = node.global_position

func object_picked():
	self.reset()
	self.freeze = true
	$CollisionShape3D.disabled = true
	
	mesh_transparency_enabled = true
	$Normal.visible = false
	$MeshTransparency.visible = true

func object_release():
	self.reset()
	self.freeze = false
	$CollisionShape3D.disabled = false
	
	mesh_transparency_enabled = false
	$Normal.visible = true
	$MeshTransparency.visible = false


func reset():
	position = Vector3(0,0,0)
	



	

