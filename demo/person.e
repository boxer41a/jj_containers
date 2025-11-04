note
	description: "[
		Class for testing class {JJ_BACK_LINKABLE}
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

class
	PERSON

inherit

	JJ_BACK_LINKABLE
		rename
			item as spouse,
			link as marry,
			unlink as divorce
		redefine
			item_anchor
		end

create
	make

feature {NONE} -- Initialziation

	make (a_name: STRING; a_gender: GENDER)
			-- Create an instance
		do
			name := a_name
			gender := a_gender
		end

feature -- Access

	name: STRING
			-- The person's name

	gender: GENDER
			-- The person's gender {GENDER}.male or .female

feature -- Basic operations

	show
			-- Print the attributes
		do
			print (generating_type + "  " + name + ", " + gender.out + "  is  ")
			if is_linked then
				print ("married to  " + spouse.name)
			else
				print ("NOT married")
			end
			print ("%N")
		end

feature {NONE} -- Implementation

	item_anchor: PERSON
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
