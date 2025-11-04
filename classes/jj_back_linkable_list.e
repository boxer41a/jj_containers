note
	description: "[
		A {LIST] that holds objects that must contain a reference
		back to this list.
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

class
	JJ_BACK_LINKABLE_SET [G -> JJ_BACK_LINKABLE_ITEM]

inherit

	JJ_SORTABLE_SET [G]
		rename
			extend as list_extend,
			prune as list_prune,
			merge as list_merge
		redefine
			default_create
		end

create
	default_create

create {JJ_BACK_LINKABLE_SET}
	make

feature -- Initialization

	default_create
			-- Provide a default to create empty list
		do
			make (100)
			set_ordered
		ensure then
			is_stable: is_stable
		end

feature -- Access

feature -- Status report

	is_stable: BOOLEAN
			-- Is Current in a consistent state (i.e. the invariant
			-- holds?  Not so during `extend' and `prune' processing
		do
			Result := not is_unstable
		ensure
			definition: Result implies not is_unstable
		end

feature -- Query

	can_merge (a_other: like Current): BOOLEAN
			-- Can all items in `a_other' be added to Current?
		do
				-- Ability to join the first items implies all others as well
			Result := is_empty or else i_th (1).can_join_list (a_other)
		end

feature -- Basic operations

	merge (a_other: like Current)
			-- Place items from `a_other' and Current into the same list
		require
			different_lists: a_other /= Current
			not_empty: not is_empty
			other_not_empty: not a_other.is_empty
			can_merge: can_merge (a_other)
		local
			i: INTEGER
			x: like item
		do
			from
			until is_empty
			loop
				i_th (1).join_list (a_other)
			end
		end

	extend (a_item: like item)
			-- Add `a_item' to Current
		require
			can_join: a_item.can_join_list (Current)
		do
			if not has (a_item) then
				set_unstable
				list_extend (a_item)
				if not a_item.is_listed or else a_item.list /= Current then
					a_item.join_list (Current)
				end
				set_stable
			end
		ensure
			has_item: has (a_item)
			item_is_listed: a_item.is_listed
			is_listed_in_current: a_item.list = Current
		end

	prune (a_item: like item)
			-- Remove `a_item' from Current
		require
			has_item: has (a_item)
		do
			set_unstable
			if a_item.is_listed then
				check
					is_in_current: a_item.list = Current
						-- because ... consistency?
				end
				a_item.leave_list (Current)
			end
			list_prune (a_item)
			set_stable
		ensure
			not_has_item: not has (a_item)
		end

feature {JJ_BACK_LINKABLE_SET} -- Implementation

	set_stable
			-- Make `is_stable' true
		do
			is_unstable := False
		ensure
			is_stable: is_stable
			definition: not is_unstable
		end

	set_unstable
			-- Make `is_stable' False
		do
			is_unstable := True
		ensure
			not_stable: not is_stable
			definition: is_unstable
		end

	is_unstable: BOOLEAN
			-- Is Current in a non-consistent state?
			-- True during `extend' or `prune' processing.
			-- Used as implementation of `is_stable' so it can default
			-- to False.

invariant

	items_reference_current: is_stable implies (across Current as it all it.item.list = Current end)

end
