note
	description: "[
		ARRAYED_SET with added feature for replacing an existing item.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2014-10-31 18:17:42 -0700 (Fri, 31 Oct 2014) $"
	revision:	"$Revision: 49 $"

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
--			put,
			prune,
			array_item,
			is_inserted,
			changeable_comparison_criterion		-- Possibly allows duplicates
		select
			put
		end

	JJ_ARRAYED_LIST [G]
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
