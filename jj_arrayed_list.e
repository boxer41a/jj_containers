note
	description: "[
		An {ARRAYED_LIST} but with feature `prune' changed to remove the first
		occurance of an item after the *beginning* of the list instead of after
		the current cursor postion.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2009, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2014-01-11 06:39:40 -0500 (Sat, 11 Jan 2014) $"
	revision:	"$Revision: 21 $"

class
	JJ_ARRAYED_LIST [G]

inherit

	ARRAYED_LIST [G]
		rename
			replace as list_replace,
			after as is_after,			-- I just don't like the original names
			before as is_before,
			full as is_full
		redefine
			prune,						-- to prune from beginning of list
			array_item
		select
			prune
		end

	ARRAYED_LIST [G]
		rename
			prune as prune_ise,			-- to keep the original version
			replace as list_replace,
			after as is_after,
			before as is_before,
			full as is_full
		redefine
			array_item
		end

create
	make, make_filled

feature -- Access

	as_set: JJ_ARRAYED_SET [G]
			-- The set of items in Current.
		local
			i: INTEGER
		do
			create Result.make (count)
			from i := 1
			until i > count
			loop
				Result.extend (i_th (i))
				i := i + 1
			end
		end

feature -- Basic operations

	prune (a_item: like item)
			-- Remove first occurance of `a_item' starting at the first item.
			-- Move cursor to right neighbor.
			-- (or `after' if no right neighbor or if `a_item' does not occur).
		do
			start
			Precursor {ARRAYED_LIST} (a_item)
		end

	replace (a_item, a_new_item: like item)
			-- Remove `a_item' and insert `a_new_item'.
		require
			item_exists: a_item /= Void
			new_item_exists: a_new_item /= Void
			has_item: has (a_item)
		local
			i: INTEGER
		do
			i := index
			start
			search (a_item)
			check
				at_correct_item: equal (item, a_item)
			end
			list_replace (a_new_item)
			go_i_th (i)
		ensure
			has_new_item: has (a_new_item)
			count_same: count = old count
		end

feature -- Status report

	is_all_same: BOOLEAN
			-- Are all the elements in Current equivalent?
			-- Uses object comparison to check sameness.
		local
			i: INTEGER_32
			a: detachable ANY
		do
				-- Simple check if all are same as the first.
				-- Assume true until finding a contradiction
			a := at (i)
			Result := True
			from i := 2
			until not Result or else i > count
			loop
				Result := a ~ at (i)
				i := i + 1
			end
		end

	is_all_different: BOOLEAN
			-- Are all the elements in Current different from each other?
			-- Uses object comparison not reference comparison
		local
			i, j: INTEGER_32
			a: detachable ANY
		do
				-- Must check all against each of the others.
				-- Assume true until finding two that are the same.
			Result := True
			from i := 1
			until not Result or else i > count
			loop
				from j := i + 1
				until not Result or else j > count
				loop
					Result := not (a ~ at (i))
					j := j + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	array_item (i: INTEGER): like item
			-- Entry at index `i', if in index interval.
			-- Redefined to make result type "like item" instead of type G.
		do
			Result := Precursor {ARRAYED_LIST} (i)
		end

end
