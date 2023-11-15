note
	description: "[
		An {ARRAYED_STACK} which allows inspection of any item, not just the
		top one.  Items are still added to and removed from the top.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_ARRAYED_STACK [G]

inherit

	ARRAYED_STACK [G]
		export
			{ANY}
				i_th,
				first,
				last,
				valid_index,
				do_all,
				do_all_with_index,
				do_if,
				do_if_with_index,
				for_all,
				there_exists
		redefine
			array_item
		end

create
	make, make_filled

feature {NONE} -- Implementation

	array_item (i: INTEGER): like item
			-- Entry at index `i', if in index interval.
			-- Redefined to make result type "like item" instead of type G.
		do
			Result := Precursor {ARRAYED_STACK} (i)
		end

end
