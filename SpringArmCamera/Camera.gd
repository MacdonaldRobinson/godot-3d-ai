extends SpringArm

onready var camera:ClippedCamera = $ClippedCamera
var mouse_sensitivity:float = 20

export var nodePathToTrack:NodePath
onready var nodeToTrack:Spatial = get_node(nodePathToTrack)

var next_spring_length:float = self.spring_length

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.add_exception(nodeToTrack)
	
func _process(delta):
	self.transform.origin = nodeToTrack.transform.origin
	self.transform.origin.y = self.transform.origin.y + 2
	
	if next_spring_length < 2:
		next_spring_length = 2
	elif next_spring_length > 100:
		next_spring_length = 100
	
	if next_spring_length != self.spring_length:
		self.spring_length = lerp(self.spring_length, next_spring_length, 0.1)


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("mouse_capture"):
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:	
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
								
	elif event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			var xdeg = deg2rad(event.relative.x)
			var ydeg = deg2rad(event.relative.y)
			
			self.rotation_degrees.x = clamp(self.rotation_degrees.x - ydeg * mouse_sensitivity, -75, 75)
			self.rotation_degrees.y = self.rotation_degrees.y - xdeg * mouse_sensitivity	
			
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			next_spring_length = self.spring_length-3
		elif event.button_index == BUTTON_WHEEL_DOWN:
			next_spring_length = self.spring_length+3
	
		
		
