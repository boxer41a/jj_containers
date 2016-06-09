note
	description: "[
		An arrayed list that cannot change size.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2014, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2011-03-21 23:11:57 -0400 (Mon, 21 Mar 2011) $"
	revision:	"$Revision: 7 $"

class
	JJ_FIXED_ARRAY [G]

inherit

	FIXED [G]
		rename
			full as is_full
		undefine
			copy,
			is_equal
		end

	JJ_ARRAYED_LIST [G]
		undefine
			is_full,
			resizable
		end

create
	make,
	make_filled

end

