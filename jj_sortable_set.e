note
	description: "[
		A set, implemented as an array, whose items *can* be ordered based on
		a total-order relationship.
		Feature `set_ordered' causes `extend' to place an item into the array
		at its proper sort-order position.
		Feature `prune' is redefined in {JJ_ARRAYED_LIST} to remove the first
		occurrence of an item at or after the beginning of the list, not after
		the	current position, as in {ARRAYED_LIST}.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_SORTABLE_SET [G -> COMPARABLE]

inherit

	JJ_ARRAYED_SET [G]
		export
			{ANY}
				for_all,
				there_exists,
				capacity,
				i_th
		undefine
			put,
			sequence_put,
			prune,
			array_item,
			is_inserted,
			has
		redefine
			extend
		select
			put,
			extend
		end

	JJ_SORTABLE_ARRAY [G]
		rename
			has as has alias "∋",
			extend as jj_sl_extend
		export {ANY}
			i_th
		undefine
			changeable_comparison_criterion,
			replace
		end

create
	make, make_filled

feature -- Basic operations

	extend (a_item: like item)
			-- Put `a_item' into Current at `seek_position' if
			-- not alread in the array.
		local
			i: INTEGER
		do
			if not has (a_item) then
				i := seek_position (a_item).position
				if i > count then
						-- add `a_item' at the end
					force (a_item)
				else
						-- add `a_item' at its ordered position
					insert (a_item, i)
				end
			end
		end

end
