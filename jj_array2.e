note
	description: "[
		A 2-d array with some additional features, including those added
		by class {JJ_ARRAY}.
		]"
	author:    "Jimmy J. Johnson"
	date:      "10/27/21"
	copyright: "Copyright (c) 2021, Jimmy J. Johnson"
	license:   "Eiffel Forum v2 (http://www.eiffel.com/licensing/forum.txt)"

class
	JJ_ARRAY2 [G]

inherit

	ARRAY2 [G]

	JJ_ARRAY [G]
		rename
			make as array_make,
			item as array_item,
			put as array_put,
			force as array_force,
			resize as array_resize,
			wipe_out as array_wipe_out,
			make_filled as array_make_filled
		export
			{NONE}
				array_make, array_force,
				array_resize, array_wipe_out, make_from_array,
				array_make_filled, make_from_special, make_from_cil,
				remove_head, remove_tail, keep_head, keep_tail,
				grow, conservative_resize, conservative_resize_with_default,
				automatic_grow
			{ARRAY2}
				array_put, array_item
			{ANY}
				copy, is_equal, area, to_c
		end

create
	make,
	make_filled

feature -- Query

	occurrences_per_row (a_item: G; a_row: INTEGER_32): INTEGER_32
			-- The number of times `a_item' appears in `a_row'.
		require
			row_index_big_enough: a_row >= 1
			row_index_small_enough: a_row <= height
		local
			i: INTEGER
		do
			from i := 1
			until i > width
			loop
				if a_item ~ item (a_row, i) then
					Result := Result + 1
				end
				i := i + 1
			end
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= width
		end

	occurrences_per_column (a_item: G; a_column: INTEGER_32): INTEGER_32
			-- The number of times `a_item' appears in `a_column'.
		require
			column_index_big_enough: a_column >= 1
			column_index_small_enough: a_column <= width
		local
			i: INTEGER
		do
			from i := 1
			until i > height
			loop
				if a_item ~ item (i, a_column) then
					Result := Result + 1
				end
				i := i + 1
			end
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= height
		end

end
