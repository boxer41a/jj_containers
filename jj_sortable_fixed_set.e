note
	description: "[
		An array that can be sorted and cannot resize.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_SORTABLE_FIXED_SET [G -> COMPARABLE]

inherit

	FIXED [G]
		rename
			has as has alias "∋",
			full as is_full
		undefine
			changeable_comparison_criterion,
			copy,
			is_equal
		end

	JJ_SORTABLE_SET [G]
		undefine
			is_full,
			resizable
		end

create
	make, make_filled

end
