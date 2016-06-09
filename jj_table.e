note
	description: "[
		A {HASH_TABLE} allowing access to a `value' with a key when the key
		key is known to be in the table.  Feature `value' wraps	`item' in
		an attachment check to remove the need to program an attachment check
		every time an item is retrieved from the table.
		Use `value' instead of `item'
	]"
	author:		"Jimmy J. Johnson"
	copyright:	"Copyright 2010, Jimmy J. Johnson"
	URL: 		"$URL: $"
	date:		"$Date: $"
	revision:	"$Revision: 35 $"

class
	JJ_TABLE [G, K -> HASHABLE]

inherit

	HASH_TABLE [G, K]

create
	make,
	make_equal

feature -- Access

	value (a_key: K): G
			-- Item associated with `a_key'.  `A_key' must be present.
		require
			has_key: has (a_key)
		do
			check attached item (a_key) as v then
				Result := v
			end
		end

end
