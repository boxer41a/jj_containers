note
	description: "[
		An array that can be sorted and cannot resize.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2014-06-08 19:47:06 -0400 (Sun, 08 Jun 2014) $"
	revision:	"$Revision: 2 $"

class
	JJ_SORTABLE_FIXED_SET [G -> COMPARABLE]

inherit

	FIXED [G]
		rename
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
