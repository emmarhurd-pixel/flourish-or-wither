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

func _start_current() -> void:
	if current_index < timeline_queue.size():
		Dialogic.start(timeline_queue[current_index])
	else:
		pass

func _on_timeline_ended() -> void:
	current_index += 1
	_start_current()

@onready var closedBag: TextureRect = $background/props/closedBag
@onready var mangroveSeed: TextureRect = $background/props/mangroveSeed
@onready var sapling: TextureRect = $background/props/mangroveSapling
# @onready var flourished: TextureRect = $Props/FlourishedTree

func _ready() -> void:
	# Connect BEFORE Dialogic.start, or any early signal fires into nothing.
	Dialogic.signal_event.connect(_on_dialogic_signal)
	# Opening state: only the closed bag.
	# seed.hide()
	sapling.hide()
	# flourished.hide()
	Dialogic.start("opening_timeline")
	

func _on_dialogic_signal(argument: String) -> void:
	match argument:
	#	"show_seed":
#			_swap_to(eed)
		"show_planted":
			_swap_to(sapling)
		#"show_tree":
			#_swap_to(flourished)

# Swaps to one prop, hiding the others
func _swap_to(node: TextureRect) -> void:
	for s in [closedBag, seed, sapling]:
		s.hide()
	node.show()
