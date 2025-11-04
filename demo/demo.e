note
	description: "[
		Demo back-linkable containers
		]"
	author: "Jimmy J Johnson"
	date: "11/4/25"

class
	DEMO

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			print ("%N%N%N%N%N%N%N%N%N")
			print ("Begin demo %N")
				-- Create objects to test {JJ_BACK_LINKABLE}
			create alice.make ("Alice", {GENDER}.female)
			create bob.make ("Bob", {GENDER}.male)
			create carol.make ("Carol", {GENDER}.female)
			create dave.make ("Dave", {GENDER}.male)
				-- Create objects to test {JJ_BACK_LINKABLE_SET} (i.e. {SHIP}s)
			create akagi.make ("Akagi")
			create kaga.make ("Kaga")
			create soryu.make ("Soryu")
			create hiryu.make ("Hiryu")
			create shokaku.make ("Shokaku")
			create zuikaku.make ("Zuikadu")
				-- Create {VITP_CELL} objects
			create cell_1.make (1)
			create cell_2.make (2)
			create cell_3.make (3)
			create cell_4.make (4)
				-- Run tests
			test_back_linkable
			test_back_linkable_set
			test_cell_ship_relations
			print ("%N  end program  %N")
		end

feature -- Basic operations

	show_back_linkables
			-- Output the state
		do
			print ("%N%N ------------------- %N")
			bob.show
			alice.show
			carol.show
			dave.show
		end

	test_back_linkable
			-- Test the {JJ_BACK_LINKABLE} class
		do
				-- `bob' marries `alice'
			bob.marry (alice)
			show_back_linkables
				-- `bob' divorces
			bob.divorce
			show_back_linkables
				-- `bob' marries `alice' and then `carol'
			bob.marry (alice)
			bob.marry (carol)
			show_back_linkables
				-- `bob' marries `alice' again and `carol marries `dave'
			bob.marry (alice)
			carol.marry (dave)
			show_back_linkables
				-- `bob' marries `carol' messng up the other marrage
			bob.marry (carol)
			show_back_linkables
		end

	show_ships
			-- Display each {BACK_LINKABLE_ITEM} (i.e. the {SHIP}s)
		do
			print ("%N%N ------------------- %N")
			akagi.show
			hiryu.show
			kaga.show
			shokaku.show
			soryu.show
			zuikaku.show
		end

	test_back_linkable_set
			-- Test the {BACK_LINKABLE_SET} class
		local
			set: JJ_BACK_LINKABLE_SET [SHIP]
		do
			show_ships
				-- temp
			create set
			set.set_ordered
			akagi.join (kaga)
			show_ships
			hiryu.join (Soryu)
			show_ships
			hiryu.join (akagi)
			show_ships
			akagi.task_force.prune (kaga)
			show_ships
			soryu.join (zuikaku)
			show_ships

			print ("%N%N")
			print ("test merge")
			zuikaku.task_force.merge (akagi.task_force)
			show_ships
		end

	test_cell_ship_relations
			-- Test {SHIP} and {VITP_CELL} functions
		do
			print ("%N  `test_cell_ship_relaions %N")
			show_ships
			print ("  placing ships in cells %N")
			akagi.link (cell_1)
			hiryu.link (cell_2)
			kaga.link (cell_3)
			shokaku.link (cell_4)
			show_ships
			print ("  move and/or unlink ships %N")
			kaga.unlink
			shokaku.link (cell_2)
			show_ships
		end

feature {NONE} -- Implementation

	alice: PERSON

	bob: PERSON

	carol: PERSON

	dave: PERSON

feature {NONE} -- Implementation

	akagi: SHIP

	hiryu: SHIP

	kaga: SHIP

	shokaku: SHIP

	soryu: SHIP

	zuikaku: SHIP

feature {NONE} -- Implementation\

	cell_1: VITP_CELL

	cell_2: VITP_CELL

	cell_3: VITP_CELL

	cell_4: VITP_CELL

end
