note
	description: "[
		Represents a task force, as in VITP, for tesing {JJ_BACK_LINKABLE_SET},
		containing two or more {SHIP} objects.
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

class
	TASK_FORCE

inherit

	JJ_BACK_LINKABLE_SET [SHIP]
		redefine
			merge,
			prune,
			extend
		end

create
	default_create

create {JJ_BACK_LINKABLE_SET}
	make

feature -- Basic operations

	merge (a_other: like Current)
			-- Place items from `a_other' and Current into the same list
		local
			s: like item
		do
				-- Redefined, because `prune', called during the loop, would remove
				-- the last item without putting it into the combined list
			from
			until is_empty
			loop
				if count = 2 then
						-- capture the one that will be lost when `prune' is called
					s := i_th (2)
					i_th (1).join_task_force (a_other)
					check
						is_empty: is_empty
							-- because `prune' removes the last item
					end
					s.join_task_force (a_other)
				else
					i_th (1).join_task_force (a_other)
				end
			end

		end

	extend (a_item: like item)
			-- Add `a_item' to Current
		do
			Precursor (a_item)
				-- Keep Current as `is_unstable' until it contains two or more items
			if count = 1 then
				set_unstable
			end
		end

	prune (a_item: like item)
			-- Remove `a_item' from Current
			-- Redefined because of strengtened invariant (two or more item)
		do
			Precursor (a_item)
			if count = 1 then
				prune (i_th (1))
			end
		end

invariant

	stable_count_implication: is_stable implies (is_empty or else count >= 2)

end
