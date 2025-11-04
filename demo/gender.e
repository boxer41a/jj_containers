note
	description: "[
		Represents male or female gender
		]"
	author: "Jimmy J Johnson"
	date: "7/6/25"

once class
	GENDER

inherit

	ANY
		redefine
			out
		end

create
	male,
	female

feature {NONE} -- Initialization

	male
			-- Create one and only one instance of this gender
		once
		end

	female
			-- Create one and only one instance of this gender
		once
		end

feature -- Access

	out: STRING
			-- Printable reprsentation
		do
			if Current = {GENDER}.male then
				Result := "male"
			else
				Result := "female"
			end
		end

feature -- Basic operations

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
