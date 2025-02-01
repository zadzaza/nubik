class_name Player extends CharacterBody3D

@export_category("Player")
@export_range(1, 35, 1) var max_speed: float = 7 # m/s
@export_range(1, 35, 1) var sprint_speed: float = 10 # m/s
@export_range(10, 400, 1) var acceleration: float = 35 # m/s^2
var speed = max_speed

@export_range(0.1, 3.0, 0.1) var max_jump_height: float = 14 # m
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1.5
var jump_height: float = max_jump_height # m

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_dir: Vector2 # Input direction for movement
var look_dir: Vector2 # Input direction for look/aim

var walk_vel: Vector3 # Walking velocity 
var grav_vel: Vector3 # Gravity velocity 
var jump_vel: Vector3 # Jumping velocity

var is_burn: bool = false

@onready var camera: Camera3D = $Camera3D
@onready var pause_manager: PauseManager = $Control/PauseManager
@onready var scope: Panel = $Control/Scope
@onready var pause: HBoxContainer = $Control/Pause
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var hud: Control = $CanvasLayer/HUD

# To track interstitial state changes, connect to the signal
func _ready():
	
	
	audio_stream_player.play(0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		capture_mouse()
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		jumping = true
		
	velocity = _walk(delta) + _gravity(delta) + _jump(delta)
	move_and_slide()

func show_restart():
	hud.show_pause(true)

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)

func _walk(delta: float) -> Vector3:
	move_dir = Input.get_vector("left", "right", "up", "down")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * speed * move_dir.length(), acceleration * delta)
	#if Input.is_action_pressed("sprint") and is_on_floor() and Input.is_action_pressed("up"): 
		#speed = sprint_speed
	#if Input.is_action_just_released("sprint"): 
		#speed = max_speed
	return walk_vel

func _gravity(delta: float) -> Vector3:
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	return grav_vel

func _jump(delta: float) -> Vector3:
	if jumping:
		if is_on_floor(): jump_vel = Vector3(0, jump_height, 0)
		jumping = false
		return jump_vel
	jump_vel = Vector3.ZERO if is_on_floor() else jump_vel.move_toward(Vector3.ZERO, gravity * delta)
	jump_height = max_jump_height
	return jump_vel

func burn():
	if not is_burn:
		is_burn = true
		$FireAnim.show()
		await get_tree().create_timer(1.1).timeout
		show_restart()

func _on_pause_manager_pause() -> void:
	release_mouse()
	scope.hide()
	pause.show()
	audio_stream_player.playing = false

func _on_pause_manager_resume() -> void:
	scope.show()
	pause.hide()
	audio_stream_player.playing = true

func _on_exit_btn_pressed() -> void:
	pause_manager._resume()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn")

func _on_continue_btn_pressed() -> void:
	pause_manager._resume()
