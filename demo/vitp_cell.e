note
	description: "[
		Class for testing class {JJ_BACK_LINKABLE}, relating to Victory in the Pacific
		]"
	author: "Jimmy J Johnson"
	date: "11/3/25"

class
	VITP_CELL
	
inherit

	JJ_BACK_LINKABLE
		rename
			item as ship
		redefine
			item_anchor
		end

create
	make

feature {NONE} -- Initialization

	make (a_number: like id)
			-- Create an instance
		do
			id := a_number
		end

feature -- Access

	id: INTEGER
			-- Identifier for Current

feature -- Basic operations

	show
			-- Display information about Current
		do
			print (generating_type + " number:  " + id.out)
			if is_linked then
				print ("  is linked to " + ship.name)
			else
				print (" is NOT linked")
			end
			print ("%N")
		end

feature {NONE} -- Implementation

	item_anchor: SHIP
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because gives no info; simply used as anchor.
			end
		end

end
