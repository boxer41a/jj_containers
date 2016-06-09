note
	description: "[
		This class adds some useful features to the ARRAY class.
		]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2010, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: 2012-03-14 00:40:22 -0400 (Wed, 14 Mar 2012) $"
	revision:	"$Revision: 9 $"

class
	JJ_ARRAY [G]

inherit

	ARRAY [G]

create
	make,
	make_filled,
	make_from_array,
	make_from_special,
	make_from_cil

convert
	to_cil: {NATIVE_ARRAY [G]},
	to_special: {SPECIAL [G]},
	make_from_cil ({NATIVE_ARRAY [G]})


feature -- Measurement

	most_occuring_item: like item
			-- The item in Current that occurs the most times.
			-- If more than one item occurs the same most number of time, then
			-- the then the first of those items.
		require
			not_empty: not is_empty
		local
			i, j: INTEGER_32
			n, c: INTEGER_32
			index: INTEGER_32
		do
			c := 0
			n := 1
			from i := 1
			until i > count
			loop
				c := 1
				from j := i + 1
				until j > count
				loop
					if at (i) ~ at (j) then
						c := c + 1
					end
					j := j + 1
				end
				if c > n then
					index := i
				end
				i := i + 1
			end
			check
				index_big_enough: index >= 1
			end
			check
				index_small_enough: index <= count
			end
			Result := at (index)
		end

	unique_count: INTEGER_32
			-- The number of items in Current that occur only once.
		local
			i, j: INTEGER_32
			n: INTEGER_32
			checked: ARRAYED_SET [like item]
			duplicate_found: BOOLEAN
			v: like item
		do
			create checked.make (count)
			from i := 1
			until i > count
			loop
				n := 1
				v := at (i)
				duplicate_found := False
				if not checked.has (v) then
					checked.extend (v)
					from j := i + 1
					until duplicate_found or else j > count
					loop
						if at (i) ~ at (j) then
							duplicate_found := True
						end
						j := j + 1
					end
				end
				if not duplicate_found then
					Result := Result + 1
				end
				i := i + 1
			end
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
			all_unique_implication:
		end

feature -- Status report

	is_all_same: BOOLEAN
			-- Are all the elements in Current equivalent?
			-- Uses object comparison to check sameness.
		local
			i: INTEGER
			a: detachable ANY
		do
				-- Simple check if all are same as the first
				-- Assume true until finding a contradiction
			a := at (1)
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
			-- Uses object comparison not reference comparison.
		local
			i, j: INTEGER_32
			a: detachable ANY
		do
				-- Must check all against each of the others.
				-- Assume true until finding two that are the same.
			Result := True
			from i := 1
			until i > count
			loop
				a := at (i)
				from j := i + 1
				until not Result or else j > count
				loop
					Result := not (a ~ at (i))
					j := j + 1
				end
				i := i + 1
			end
		end

end
