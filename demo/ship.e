note
	description: "[
		Represents a ship, a in VITP, for tesing {JJ_BACK_LINKABLE_SET}

		It is implemented as a {JJ_BACK_LINKABLE_ITEM} which an be contaned
		(i.e. `join') only two {JJ_BACK_LINKABLE_SET}s--one is the a `task_force'
		and the other is a `cell'.
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

class
	SHIP

inherit

JJ_BACK_LINKABLE_ITEM
		rename
			make as item_make,
			list as task_force,
			join_list as join_task_force,
			leave_list as leave_task_force,
			is_listed as is_task_force,
			list_imp as task_force_imp
		redefine
--			join_task_force,
			item_anchor,
			list_anchor
		end

JJ_BACK_LINKABLE
	rename
		item as cell,
		is_stable as is_back_linkable_stable,
		set_stable as set_back_linkable_stable,
		set_unstable as set_back_linkable_unstable,
		is_unstable as is_back_linkable_unstable,
		item_anchor as back_linkable_item_anchor
	undefine
		is_equal
	redefine
		back_linkable_item_anchor
	end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
			-- Create an instance with `a_name'
		do
			name := a_name
			item_make
		end

feature -- Access

	name: STRING
			-- The name of Current

feature -- Basic operations

feature -- Status report

feature -- Query

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := name < other.name
		end

feature -- Basic operations

	show
			-- Display Current
		do
			print (generating_type + ":  " + name)
			if is_task_force then
				print ("  is in  " + task_force.i_th (1).name + "'s list -- ")
				from task_force.start
				until task_force.is_after
				loop
					print (task_force.item_for_iteration.name)
					task_force.forth
					if not task_force.is_after then
						print (", ")
					else
						print (".  ")
					end
				end
			else
				print ("  NOT in a task_force.  ")
			end
			if is_linked then
				print ("It is located in {CELL}  " + cell.id.out)
			else
				print ("It is NOT located in a {CELL}")
			end
			print (". %N")
		end

feature {NONE} -- Implementation

--	task_force_imp: detachable like task_force
--			-- Implementation for `task_force'

feature {NONE} -- Anchors (for covariant redefinitions)

	item_anchor: SHIP
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because give no info; simply used as anchor.
			end
		end

	list_anchor: TASK_FORCE
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because give no info; simply used as anchor.
			end
		end

	back_linkable_item_anchor: VITP_CELL
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because give no info; simply used as anchor.
			end
		end
end
