note
	description: "[
		Items that can be placed into a {BACK_LINKABLE_LIST} and
		maintain a reference back to that list
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

deferred class
	JJ_BACK_LINKABLE_ITEM

inherit

	COMPARABLE

feature {NONE} -- Initialization

	make
			-- Create an instance
		do
		ensure
			not_listed: not is_listed
		end

feature -- Access		

	list: like list_anchor
			-- The one list in which Current resides
		require
			is_listed: is_listed
		do
			check attached list_imp as x then
				Result := x
			end
		end

feature -- Status report

	is_listed: BOOLEAN
			-- Is Current contained in a `list'?
		do
			Result := attached list_imp
		ensure
			definition: Result implies attached list_imp
		end

	is_stable: BOOLEAN
			-- Is Current in a consistent state (i.e. the invariant
			-- holds?  Not so during `extend' and `wipe_out' processing
		do
			Result := not is_unstable
		ensure
			definition: Result implies not is_unstable
		end

feature -- Query

	can_join (a_other: like item_anchor): BOOLEAN
			-- Can Current be placed into the same `list' as `a_other?
			-- Redefine to allow strengthening of precondition to `join'
		do
			Result := True
		end

	can_join_list (a_list: like list): BOOLEAN
			-- Can Current be placed into `a_list'?
		do
			Result := a_list.is_empty or else can_join (a_list.i_th (1))
		end

feature -- Basic operations

	join (a_other: like item_anchor)
			-- Place Current in the same `list' as `a_other'
		require
			can_join: can_join (a_other)
		local
			n: like list_anchor
		do
			if a_other.is_listed then
				join_list (a_other.list)
			elseif is_listed then
				a_other.join_list (list)
			else
				list_imp := new_list
				list.extend (Current)
				list.extend (a_other)
			end
		end

	withdraw
			-- Remove Current from it's `list'
		require
			is_listed: is_listed
		local
			s: like list
		do
			leave_list (list)
		end

	join_list (a_list: like list_anchor)
			-- Add Current to `a_list' and ensure `list' is equal to `a_list'
		require
			can_join:  can_join_list (a_list)
		do
			set_unstable
				-- Remove Current from any list it may already be in
			if is_listed then
				check
					is_listed: list.has (Current)
						-- because ... ?
				end
				list.prune (Current)
				list_imp := Void
			end
				-- Add Current to `a_list'
			if not a_list.has (Current) then
				a_list.extend (Current)
			end
			list_imp := a_list
			set_stable
		ensure
			is_listed: is_listed
			is_in_new_list: a_list.has (Current)
			list_recorded: list = a_list
		end

	leave_list (a_list: like list_anchor)
			-- Ensure Current is not contained in `a_list'
		require
			is_listed: is_listed
			is_in_a_list: a_list.has (Current)
		local
			n: like item_anchor
		do
			set_unstable
			check
				listed: list = a_list
					-- because ... ? for consistency?
			end
			list_imp := Void
			a_list.prune (Current)
			set_stable
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

	list_imp: detachable like list
			-- Detachable implementation of `list'

	new_list: like list_anchor
			-- Feature needed to allow this class to create instances for
			-- `list' when a descendant does not have the same signature
			-- for making a list.
			-- Redefine if signature of `make is changed.
			-- See class {TASK_FORCE} from Victory in the Pacific for an
			-- example.  Feature `make' from {TASK_FORCE} needs a `game'
			-- argument, but this class has no such game attribute to use
			-- when a new `list' is created here, as in feature `withdraw'.
		do
			create Result.default_create
		end

feature {NONE} -- Anchors (for covariant redefinitions)

	item_anchor: JJ_BACK_LINKABLE_ITEM
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

	list_anchor: JJ_BACK_LINKABLE_SET [like item_anchor]
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

	stable_implication: is_stable implies (is_listed and then list.has (Current) or else not is_listed)

end

