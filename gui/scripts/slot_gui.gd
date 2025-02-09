extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var centerContainer: CenterContainer = $CenterContainer

var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1
	centerContainer.add_child(itemStackGui)
