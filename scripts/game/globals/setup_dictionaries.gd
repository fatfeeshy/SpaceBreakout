extends Node

var last_setup_num := 3
# Up to 11 small enemies in 1 row
# Up to 6 medium enemies in 1 row (with space left over)
# Up to 5 large enemies in 1 row (with space left over)

static var setup_dict = {
	1: { # All large
	Vector2(0,0): "large",
	Vector2(2,0): "large",
	Vector2(4,0): "large",
	Vector2(6,0): "large",
	Vector2(8,0): "large",
	},
	2: { # All medium
	Vector2(0,0): "medium",
	Vector2(2,0): "medium",
	Vector2(5,0): "medium",
	Vector2(7,0): "medium",
	Vector2(0,2): "medium",
	Vector2(2,2): "medium",
	Vector2(5,2): "medium",
	Vector2(7,2): "medium",
	},
	3: { # All small
	Vector2(0,0): "small",
	Vector2(1,0): "small",
	Vector2(2,0): "small",
	Vector2(3,0): "small",
	Vector2(4,0): "small",
	Vector2(5,0): "small",
	Vector2(6,0): "small",
	Vector2(7,0): "small",
	Vector2(8,0): "small",
	Vector2(0,1): "small",
	},
}
