extends KinematicBody
class_name Player

export var springArmNodePath:NodePath
onready var springArm:SpringArm = get_node(springArmNodePath)
var is_movement_pressed = false
var currentVector:Vector3 = Vector3.ZERO
var gravity:float = -20

func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("forward") || Input.is_action_pressed("backward") || Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			is_movement_pressed = true

func _physics_process(delta):
	if is_movement_pressed:		
		self.rotation.y = springArm.rotation.y
		
		if is_equal_approx(self.rotation.y, springArm.rotation.y):
			is_movement_pressed = false
	
	var zMovement:float = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	var xMovement:float = Input.get_action_strength("right") - Input.get_action_strength("left")
		
	var newVector:Vector3 = Vector3(xMovement, 0, zMovement).normalized() * 20
	
	newVector = transform.basis.xform(newVector)
	
		
	if Input.is_action_just_pressed("jump"):
		newVector.y = 500
	else:
		newVector.y = gravity
		
	newVector = lerp(currentVector, newVector, 0.1)
	currentVector = move_and_slide(newVector, Vector3.UP)
	
	
	
