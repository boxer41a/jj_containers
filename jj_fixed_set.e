note
	description: "[
		A set implemented as an array that cannot resize.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"
	URL: 		"$URL: file:///F:/eiffel_repositories/jj_support/trunk/jj_containers/jj_fixed_set.e $"
	date:		"$Date: 2014-01-21 19:47:20 -0500 (Tue, 21 Jan 2014) $"
	revision:	"$Revision: 23 $"

class
	JJ_FIXED_SET [G]

inherit

	FIXED [G]
		rename
			full as is_full
		undefine
			copy,
			is_equal,
			changeable_comparison_criterion
		end

	JJ_ARRAYED_SET [G]
		undefine
			is_full,
			resizable
		end

create
	make,
	make_filled

end
