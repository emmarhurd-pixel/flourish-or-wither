extends Node2D

var timeline_queue : Array[String] = [
	"opening_timeline",
	"decision1",
	"decision2",
	"decision3",
	"decision4",
	"decision5",
	"decision6",
	"final_timeline"
]

var current_index: int = 0

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	_start_current()

func _start_current() -> void:
	if current_index < timeline_queue.size():
		Dialogic.start(timeline_queue[current_index])
	else:
		pass

func _on_timeline_ended() -> void:
	current_index += 1
	_start_current()
