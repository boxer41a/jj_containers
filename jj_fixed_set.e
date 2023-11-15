note
	description: "[
		A set implemented as an array that cannot resize.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_FIXED_SET [G]

inherit

	FIXED [G]
		rename
			has as has alias "∋",
			full as is_full
		undefine
			copy,
			is_equal,
			changeable_comparison_criterion
		end

	JJ_ARRAYED_SET [G]
		undefine
			is_full,
			resizable
		end

create
	make,
	make_filled

end
