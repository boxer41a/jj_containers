note
	description: "[
		An array whose items *can* be ordered by a total-ordered relationship.
		Feature `set_ordered' causes `extend' to place an item into the array
		at its proper sort order position.
		Feature `prune' is redefined in {JJ_ARRAYED_LIST} to remove the first
		occurrence of an item at or after the beginning of the list, not after
		the	current position, as in {ARRAYED_LIST}.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_SORTABLE_ARRAY [G -> COMPARABLE]

inherit

	JJ_ARRAYED_LIST [G]
		export
			{NONE}
				force	-- to trap a design error temporarily
		redefine
			put,
			extend,
			replace,
			has,
			is_inserted
		end

create
	make, make_filled

feature -- Status report

	is_inserting_ordered: BOOLEAN
			-- Should items be inserted in their ordered position?
			-- The default is to add items at the end of the list; the list
			-- can be sorted later.

	is_sorted: BOOLEAN
			-- Is the structure sorted?
		local
			c: CURSOR
			prev: like item
		do
			Result := True
			if count > 1 then
				from
					c := cursor
					start
						check not off end
					prev := item
					forth
				until
					is_after or not Result
				loop
					Result := (prev <= item)
					prev := item
					forth
				end
				go_to (c)
			end
		end

feature -- Status setting

	set_ordered
			-- Sort Current and then ensure future insertions place items
			-- at their proper position based on a total order relation.
		do
			sort
			is_inserting_ordered := True
		ensure
			is_ordered: is_inserting_ordered
			is_sorted: is_sorted
		end

	set_unordered
			-- Make future insertions place items at the end of the list.
			-- This is the default.
		do
			is_inserting_ordered := False
		ensure
			not_ordered: not is_inserting_ordered
		end

feature -- Query

	has (a_item: like item): BOOLEAN
			-- Does current include `v'?
		do
			if object_comparison then
					-- can use the binary search
				Result := seek_position (a_item).was_found
			else
					-- Must check references; the binary search does not;
					-- it uses `is_less' which compares objects.
				Result := Precursor (a_item)
			end
		end

	seek_position (a_item: like item): TUPLE [position: INTEGER; was_found: BOOLEAN]
			-- The position of `a_item' in Current or the position where
			-- it would be inserted.  Sets `was_found' if `a_item' was
			-- in Current.
		local
			pos: INTEGER
			low, mid, high: INTEGER
			found: BOOLEAN
			c: CURSOR
		do
			if is_inserting_ordered then
					-- do a binary search
				check
					is_sorted: is_sorted
						-- because `is_inserting_ordered' keeps Current sorted.
				end
				from
					low := 1
					high := count
				until found or else (low > high)
				loop
					mid := (low + high) // 2
					if a_item < i_th (mid) then
						high := mid - 1
					elseif a_item > i_th (mid) then
						low := mid + 1
					else
						found := True
					end
				end
				if found then
						-- Account for duplicates
					from pos := mid
					until pos > count - 1 or else i_th (pos + 1) > a_item
					loop
						pos := pos + 1
					end
				elseif count = 0 then
					pos := 1
				elseif a_item < i_th (mid) then
					pos := mid
				else
					pos := mid + 1
				end
			else
					-- perform a linear search
				c := cursor
				start
				search (a_item)
				pos := index
				if is_after then
					found := False
				else
					found := True
				end
				go_to (c)
			end
			Result := [pos, found]
		end

	is_inserted (a_item: like item): BOOLEAN
			-- Was `a_item' inserted into Current?
			-- Redefined because {ARRAYED_LIST} always extends items at the
			-- end; that is not necessarily the case for this class.
		do
			Result := has (a_item)
		end

feature -- Basic operations

	extend (a_item: like item)
			-- Put `a_item' into Current at `seek_position'.
		local
			i: INTEGER
		do
			if is_empty or else not is_inserting_ordered then
					-- add to end
				Precursor {JJ_ARRAYED_LIST} (a_item)
			else
				i := seek_position (a_item).position
				if i > count then
						-- Add at end
					Precursor {JJ_ARRAYED_LIST} (a_item)
				else
						-- Add at ordered position.
					insert (a_item, i)
				end
			end
		ensure then
			still_sorted: is_inserting_ordered implies is_sorted
		end

	put (a_item: like item)
			-- Put `a_item' into Current at `seek_position'.
			-- Same as extend.
		do
			extend (a_item)
		end

	replace (a_item, a_new_item: like item)
			-- Remove `a_item' and insert `a_new_item'.
			-- Redefined to ensure `a_new_item' is inserted into the proper
			-- place.
		do
			prune (a_item)
			extend (a_new_item)
		end

	sort
			-- Sort all items.
			-- Has O(`count' * log (`count')) complexity.
			--| Uses comb-sort (BYTE February '91)
			-- Adapted from ISE's feature from {SORTED_TWO_WAY_LIST}.
		local
			no_change: BOOLEAN
			gap: INTEGER
			i, j: INTEGER
			left_v, v: like item
		do
			if not is_empty then
				from
					gap := count * 10 // 13
				until
					gap = 0
				loop
					from
						no_change := False
						i := 1 + gap
					until
						no_change
					loop
						no_change := True
						from
							j := 1			-- first element index
						until
							i > count
						loop
							left_v := i_th (j)
							v := i_th (i)	-- item at first index + gap
							if v < left_v then
									-- Swap `left_v' with `v'
								no_change := False
								put_i_th (left_v, i)
								put_i_th (v, j)
							end
							j := j + 1
							i := i + 1
						end
					end
					gap := gap * 10 // 13
				end
			end
		ensure
			is_sorted: is_sorted
		end

invariant

	is_inserting_ordered_implication: is_inserting_ordered implies is_sorted

end
