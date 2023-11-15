note
	description: "[
		ARRAYED_SET with added feature for replacing an existing item.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_ARRAYED_SET [G]

inherit

	ARRAYED_SET [G]
		rename
			replace as list_replace,
			after as is_after,
			before as is_before,
			full as is_full
		export
			{ANY}
				for_all,
				there_exists,
				capacity,
				i_th
		undefine
			make_from_iterable,
--			put,
			prune,
			array_item,
			is_inserted,
			changeable_comparison_criterion		-- Possibly allows duplicates
		select
			put
		end

	JJ_ARRAYED_LIST [G]
		rename
			has as has alias "∋"
		undefine
			put,
			sequence_put,
			extend,
			force
--			changeable_comparison_criterion
		redefine
			replace
		end

create
	make, make_filled

feature -- Basic operations

	replace (a_item, a_new_item: like item)
			-- If `a_new_item' is not in Current and `a_item' is, remove
			-- `a_item' and insert `a_new_item'.
		do
			if has (a_item) and then not has (a_new_item) then
				Precursor {JJ_ARRAYED_LIST} (a_item, a_new_item)
			end
		end

end
