note
	description: "[
		Objects that inforce referential integrity between itself
		and some other object.
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

class
	JJ_BACK_LINKABLE

create
	default_create

feature {NONE} -- Initialization

feature -- Access

	item: like item_anchor
			-- The back-linkable item to which Current refers
		require
			is_linked: is_linked
		do
			check attached item_imp as x then
				Result := x
			end
		end

feature -- Status report

	is_linked: BOOLEAN
			-- Does Current refer to NO item
		do
			Result := attached item_imp
		ensure
			definition: Result implies attached item_imp
		end

	is_stable: BOOLEAN
			-- Is Current in a consistent state (i.e. the invariant
			-- holds?  Not so during `extend' and `wipe_out' processing
		do
			Result := not is_unstable
		ensure
			definition: Result implies not is_unstable
		end

feature -- Basic operations

	link (a_other: like item)
			-- Link Current to `a_other', ensure `item' references
			-- `a_other' and that the `item' of `a_other' references
			-- back to Current
			-- If `a_other' was previously linked to an object, that
			-- link will be replaced as well as the other objects
			-- link to `a_other'.
		do
			if item_imp = a_other then
					-- Nothing to do if `item' and `a_other' are same
				do_nothing
			else
				set_unstable
				if is_linked then
					unlink
				end
				item_imp := a_other
				a_other.link (Current)
				set_stable
			end
		ensure
			is_linked:  is_linked
			link_was_set: item = a_other
			other_item_was_set: a_other.item = Current
		end

	unlink
			-- Ensure Current `is_empty'
		local
			x: JJ_BACK_LINKABLE
		do
			if is_linked then
				set_unstable
				x := item
				item_imp := Void
				if x.is_linked then
					x.unlink
				end
				check
					is_linked: not is_linked
					x_is_linked: not x.is_linked
				end
				set_stable
			end
		ensure
			not_linked: not is_linked
		end

feature {NONE} -- Implementation

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

	item_imp: detachable like item
			-- Detachable implementation for `item'

	item_anchor: JJ_BACK_LINKABLE
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because gives no info; simply used as anchor.
			end
		end

invariant

	is_linked_implication: (is_linked and is_stable and item.is_stable) implies item.item = Current

end
