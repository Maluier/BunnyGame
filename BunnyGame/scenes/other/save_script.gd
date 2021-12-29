extends Node

func _ready():
	pass
	
## For any objects, please remember that the following 4 keywords are reserved:
#	"filename" : get_filename(),
#	"parent" : get_parent().get_path(),
## These 2 are reserved for any 2D objects
#	"pos_x" : position.x, # Vector2 is not supported by JSON
#	"pos_y" : position.y,
#	These are required in order to rebuild the objects on load
	
func save_gamestate():
	var date = OS.get_datetime()
	var formatted_date = str(date["day"])+"-"+str(date["month"])+"-"+str(date["year"])+"-"+\
	str(date["hour"])+"_"+str(date["minute"])+"_"+str(date["second"])
	
	var save_game = File.new()
	#save_game.open("user://saved"+formatted_date+".save", File.WRITE)
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for node in save_nodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
			
		if node.has_method("is_savable"):
			if not node.is_savable():
				print("persistent node '%s' is not in a savable state, skipped" % node.name)
				continue
				
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
			
		var node_data = node.call("save")
		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	
	save_game.close()
	
func load_gamestate():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
		
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		## Globals is specifically not freed so that it does not interfere with the new globals
		if i.name != "Globals":
			i.queue_free()

	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		if "name" in node_data and node_data["name"] == "Globals":
			Globals.load(node_data)
			continue

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		if "pos_x" in node_data.keys():
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])

	save_game.close()
	call_deferred("additional_load_processing")
	
func additional_load_processing():
	var turrent_grid = get_node("/root/Test/TurrentGrid")
	var new_tower_dict = {}
	for turrent in turrent_grid.get_children():
		if turrent.is_in_group("Turrent"):
			new_tower_dict[turrent_grid.world_to_map(turrent.position)] = turrent
	turrent_grid.tower_dictionary = new_tower_dict
	
