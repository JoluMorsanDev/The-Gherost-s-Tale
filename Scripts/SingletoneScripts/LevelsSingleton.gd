extends Node

var firsttimeplaying = true
var levelsunlocked = 0
var firsttimeplayingfile = "user://firsttime.save"
var levelsunlockedfile = "user://levels.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_first_time()
	load_levels_unlocked()

func save_first_time():
	var file = File.new()
	file.open(firsttimeplayingfile, File.WRITE)
	file.store_var(firsttimeplaying)
	file.close()

func save_levels_unlocked():
	var file = File.new()
	file.open(levelsunlockedfile, File.WRITE)
	file.store_var(levelsunlocked)
	file.close()

func load_first_time():
	var file = File.new()
	if file.file_exists(firsttimeplayingfile):
		file.open(firsttimeplayingfile, File.READ)
		firsttimeplaying = file.get_var()
		file.close()
	else:
		firsttimeplaying = true

func load_levels_unlocked():
	var file = File.new()
	if file.file_exists(levelsunlockedfile):
		file.open(levelsunlockedfile, File.READ)
		levelsunlocked = file.get_var()
		file.close()
	else:
		levelsunlocked = 0

func earse_data():
	var file = File.new()
	file.open(levelsunlockedfile, File.WRITE)
	file.store_var(0)
	file.close()
	var file2 = File.new()
	file2.open(firsttimeplayingfile, File.WRITE)
	file2.store_var(true)
	file2.close()
