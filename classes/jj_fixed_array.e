note
	description: "[
		An arrayed list that cannot change size.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_FIXED_ARRAY [G]

inherit

	FIXED [G]
		rename
			full as is_full
		undefine
			copy,
			is_equal
		end

	JJ_ARRAYED_LIST [G]
		undefine
			is_full,
			resizable
		end

create
	make,
	make_filled

end

