extends Node3D

@export var fill_row : bool = true
const books = {
	"book_1" = preload("res://Scenes/Meshes/Books/book_1.gltf"),
	"book_2" = preload("res://Scenes/Meshes/Books/book_2.gltf"),
	"book_3" = preload("res://Scenes/Meshes/Books/book_3.gltf"),
	"book_4" = preload("res://Scenes/Meshes/Books/book_4.gltf"),
	"book_5" = preload("res://Scenes/Meshes/Books/book_5.gltf"),
	"book_6" = preload("res://Scenes/Meshes/Books/book_6.gltf"),
	"book_7" = preload("res://Scenes/Meshes/Books/book_7.gltf"),
	"book_8" = preload("res://Scenes/Meshes/Books/book_8.gltf"),
	"book_9" = preload("res://Scenes/Meshes/Books/book_9.gltf"),
	"book_10" = preload("res://Scenes/Meshes/Books/book_10.gltf"),
}


func generate_row():
	if not fill_row:
		return
		
	for child in self.get_children():
		if(randf() > 0.5):
			continue
		# TODO: define seed based on id
		var book_number = randi_range(1, 10)
		var book_name = "book_" + String.num_int64(book_number)
		var book = books[book_name].instantiate()
		book.position = child.position
		add_child(book)
	pass
