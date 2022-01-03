extends KinematicBody

export var navNodePath:NodePath
onready var nav:Navigation = get_node(navNodePath)

export var targetNodePath:NodePath
onready var target:KinematicBody = get_node(targetNodePath)

var threshHold = 0.1
var currentPathIndex = 0
var gravity = 9.8
var speed = 3

func _process(delta):
	var navPaths = nav.get_simple_path(self.global_transform.origin, target.global_transform.origin)
	
	for path in navPaths:
		var direction:Vector3 = path - self.global_transform.origin
		direction = direction.normalized()
		
		self.look_at(path, Vector3.UP)
		self.rotation.x = 0
			
		move_and_slide(direction * speed , Vector3.UP)
