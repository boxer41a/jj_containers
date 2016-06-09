note
	description: "[
		An {ARRAYED_STACK} which allows inspection of any item, not just the
		top one.  Items are still added to and removed from the top.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2014-03-17 21:14:08 -0400 (Mon, 17 Mar 2014) $"
	revision:	"$Revision: 36 $"

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
