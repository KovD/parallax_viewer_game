extends Node2D

var picture_size: Vector2
var resize
var PictureData: parralax_picture
var speed
var original
var center
var height
var shared_vector: Vector2 = Vector2.ZERO
var use_three_d:bool

var slice_scene = preload("res://scenes/paralax_slice.tscn")
var slice_3d_scene = preload("res://scenes/paralax_slice_3d.tscn")

func setup_paralax(picture_data: parralax_picture, heightmap:String, camera_size: Vector2, resize_number:float = 1.1, paralax_speed: int = 100, threeD:bool = false) -> void:
    resize = resize_number
    PictureData = picture_data
    original = camera_size
    speed = paralax_speed
    use_three_d = threeD
    height = heightmap
    
    
    center = Vector2(camera_size[0] / 2, camera_size[1]/2)

func _ready() -> void:
    var ref_center = Vector2.ZERO

    if PictureData.parralax_list.size() > 0:
        var first_image = load(PictureData.parralax_list[0].path)
        var texture_size = first_image.get_size()
        var target_size = original * resize 
        scale = target_size / texture_size
    if not use_three_d:
        for pictures in PictureData.parralax_list:
            var instance = slice_scene.instantiate()
            instance.setup_slice(pictures.path, pictures.depth, speed, ref_center) 
            add_child(instance)
    else:
        for pictures in PictureData.parralax_list:
            var instance = slice_3d_scene.instantiate()
            instance.setup_slice(pictures.path, height, pictures.depth, speed, ref_center) 
            add_child(instance)

func _process(delta: float) -> void:
    var mouse_pos = get_viewport().get_mouse_position() 
    
    var screen_rect = get_viewport().get_visible_rect()
    var target = Vector2.ZERO

    if screen_rect.has_point(mouse_pos):
        var offset = mouse_pos - center
        target = offset / center.x 
        target *= -1
    shared_vector = shared_vector.lerp(target, delta * 5.0)


func _on_screen_resized():
    original = get_viewport_rect().size
    
    center = original / 2
    
    if PictureData.parralax_list.size() > 0:
        var first_image = load(PictureData.parralax_list[0].path)
        var texture_size = first_image.get_size()
        var target_size = original * resize 
        scale = target_size / texture_size
