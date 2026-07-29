extends Node3D

signal interaction_completed

@onready var camera: Camera3D = $Camera3D
@onready var valve: StaticBody3D = $Valve
@onready var prompt: Label = $UI/Prompt

var is_done: bool = false
var is_interacting: bool = false

func _ready() -> void:
	prompt.text = "Click the valve to screw it in"   # placeholder copy, swap later

func _unhandled_input(event: InputEvent) -> void:
	if is_done or is_interacting:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_try_interact(event.position)

func _try_interact(mouse_pos: Vector2) -> void:
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * 100.0
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := space_state.intersect_ray(query)
	if result and result.collider == valve:
		_screw_in()

func _screw_in() -> void:
	is_interacting = true
	prompt.text = "..."   # placeholder copy
	var tween := create_tween()
	tween.tween_property(valve, "rotation:y", valve.rotation.y + TAU * 2, 1.0)
	await tween.finished
	_on_complete()

func _on_complete() -> void:
	is_done = true
	is_interacting = false
	prompt.text = "Water flowing!"   # placeholder copy
	interaction_completed.emit()
