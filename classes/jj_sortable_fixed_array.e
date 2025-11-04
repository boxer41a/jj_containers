note
	description: "[
		An array that can be sorted and cannot resize.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_SORTABLE_FIXED_ARRAY [G -> COMPARABLE]

inherit

	FIXED [G]
		rename
			full as is_full
		undefine
			copy,
			is_equal
		end

	JJ_SORTABLE_ARRAY [G]
		undefine
			is_full,
			resizable
		end

create
	make,
	make_filled

end
