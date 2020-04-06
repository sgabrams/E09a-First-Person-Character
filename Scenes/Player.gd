extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

(make sure to indent using tabs instead of spaces)

If you run the game again, you should now be able to move forward, back, strafe left and right, and look around using the mouse. If you leave the platform, you should fall.

Finally, we will add a weapon. Right click on the Pivot node, and Add Child Node. Choose MeshInstance. Name the new node Gun. Select the Gun node.

In the Assets folder (in the FileSystem panel), you should see shotgun.obj. Drag that file to the Mesh property in the Inspector

Under Spatial->Transform, set Translation->x: 0.2, y: -0.15, z: -0.3. Set Rotation Degrees->x: 180. Set Scale->x: 8, y: 8, z: 8

If you run the game again, you should now be holding a blue gun.

Save and commit your changes, Push the repository back to GitHub, and turn in a link to your repository on Canvas.



