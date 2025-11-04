note
	description: "[
		A {LINKED_STACK} which allows inspection of any item, not just the
		top one.  Items are still added to and removed from the top.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_LINKED_STACK [G]

inherit

	LINKED_STACK [G]
		export {ANY}
			i_th,
			first,
			last,
			valid_index
		redefine
			i_th,
			at
		end

create
	make

feature -- Access

	i_th alias "[]" (a_index: INTEGER): like item
			-- Redefined to anchor to item.
		do
			Result := Precursor {LINKED_STACK} (a_index)
		end

feature {NONE} -- Implementation

	at alias "@" (i: INTEGER): like item
			-- Entry at index `i', if in index interval.
			-- Redefined to make result type "like item" instead of type G.
		do
			Result := Precursor {LINKED_STACK} (i)
		end

end
