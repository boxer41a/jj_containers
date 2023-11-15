note
	description: "[
		A priority queue implemented as sorted lists, but giving
		the minimum value instead of, like Eiffel Software's class,
		the maximum value.
		]"
	author:    "Jimmy J. Johnson"
	date:      "11/11/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_MINIMUM_PRIORITY_QUEUE [G -> COMPARABLE]

inherit

	LINKED_PRIORITY_QUEUE [G]
		redefine
			item,
			remove
		end

create
	make,
	make_from_iterable

create {JJ_MINIMUM_PRIORITY_QUEUE}
	make_sublist

feature -- Access

	item: G
			-- Item at bottom of queue (i.e. smallest value)
		do
			Result := i_th (1)
		end

feature -- Removal

	remove
			-- Remove item of highest value.
		do
			go_i_th (1)
			Precursor {LINKED_PRIORITY_QUEUE}
			go_i_th (1)
		end

end
