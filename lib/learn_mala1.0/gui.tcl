package provide learn_mala 1.0

namespace eval ::gui {
	variable resize_engine ""
	variable img_current ""
	variable widget_temp ""
}

switch [lindex $tcl_platform(os) 0] {
	Windows {
		package require imgtools
		set gui::resize_engine imgtools::scale
	}
	default {
		#c est important
		tk_messageBox -message "The image loading\n may be low\n in this platform" -icon info
		set gui::resize_engine resize
	}
}

namespace eval ::gui {
	variable pady 10
	variable img_ext png
	variable img_dir [file dirname [info script]]/data/img
	wm title . "Learn Mala"
	image create photo img_temp
	menu .m
	menu .m.option -tearoff 0
	.m.option add command -label About -command "gui::About"
	.m.option add command -label Close -command "destroy .;close"
	.m add cascade -menu .m.option -label Menu
	menu .m.theme -tearoff 0
	foreach theme [ttk::themes] {
		.m.theme add command -label $theme -command "ttk::style theme use $theme"
	}
	.m add cascade -menu .m.theme -label Theme
	menu .m.padding -tearoff 0
	for {set i 0} {$i < 20} {incr i} {
		if {$i%2 == 0} {
			.m.padding add command -label $i -command "set gui::pady $i;gui::Pub"
		}
	}
	.m add cascade -menu .m.padding -label Padding
	menu .m.language -tearoff 0
	.m.language add command -label Francais -command "::msgcat::mclocale fr;gui::Pub"
	.m.language add command -label English -command "::msgcat::mclocale en;gui::Pub"
	.m add cascade -menu .m.language -label Language
	. configure -menu .m
	pack [ttk::frame .frame]
	wm iconphoto . [image create photo ico -data [binary decode hex {4749463839613c003c00e7fb000000000000330000660000990000cc0000ff002b00002b33002b66002b99002bcc002bff0055000055330055660055990055cc0055ff0080000080330080660080990080cc0080ff00aa0000aa3300aa6600aa9900aacc00aaff00d50000d53300d56600d59900d5cc00d5ff00ff0000ff3300ff6600ff9900ffcc00ffff3300003300333300663300993300cc3300ff332b00332b33332b66332b99332bcc332bff3355003355333355663355993355cc3355ff3380003380333380663380993380cc3380ff33aa0033aa3333aa6633aa9933aacc33aaff33d50033d53333d56633d59933d5cc33d5ff33ff0033ff3333ff6633ff9933ffcc33ffff6600006600336600666600996600cc6600ff662b00662b33662b66662b99662bcc662bff6655006655336655666655996655cc6655ff6680006680336680666680996680cc6680ff66aa0066aa3366aa6666aa9966aacc66aaff66d50066d53366d56666d59966d5cc66d5ff66ff0066ff3366ff6666ff9966ffcc66ffff9900009900339900669900999900cc9900ff992b00992b33992b66992b99992bcc992bff9955009955339955669955999955cc9955ff9980009980339980669980999980cc9980ff99aa0099aa3399aa6699aa9999aacc99aaff99d50099d53399d56699d59999d5cc99d5ff99ff0099ff3399ff6699ff9999ffcc99ffffcc0000cc0033cc0066cc0099cc00cccc00ffcc2b00cc2b33cc2b66cc2b99cc2bcccc2bffcc5500cc5533cc5566cc5599cc55cccc55ffcc8000cc8033cc8066cc8099cc80cccc80ffccaa00ccaa33ccaa66ccaa99ccaaccccaaffccd500ccd533ccd566ccd599ccd5ccccd5ffccff00ccff33ccff66ccff99ccffccccffffff0000ff0033ff0066ff0099ff00ccff00ffff2b00ff2b33ff2b66ff2b99ff2bccff2bffff5500ff5533ff5566ff5599ff55ccff55ffff8000ff8033ff8066ff8099ff80ccff80ffffaa00ffaa33ffaa66ffaa99ffaaccffaaffffd500ffd533ffd566ffd599ffd5ccffd5ffffff00ffff33ffff66ffff99ffffccffffffffffffffffffffffffffffff21f904010a00ff002c000000003c003c000008fe00ff091c48b0a0c17fc3f629a39729d3b0640f23eecb74b0a2c58b171326a3a74c5226880d877d7c487118c69328053afc988963434c2f9339842952993e931453ea24988966cf853445860c09d3a54c4c3b538a4123269347880b1bf6cc244c24a661343101a527d263cea40797869124098d507a20450e53e6546a4f62fa948964d8739f49b003c5fcc3b4548c32341ed7269b6455add3ab989e46edc950e857bc65c5d24313321960b6113389292b5512476589d13044dc10ec66a6651965ea283299a4a55da78659e954d242b61e17026e28ecb152a64ccfc8ed8c26ccd8b21e914f2d8bb6ab59b63d87edfe1df98c98306248925566ab57a15ebc26fe011e4f16b0c85e9264ae16d95b2acc9491812f950b5a4c32f4df19c994245e3c7f34e0d9c25f621b3524c955667974121a80f1f51a76cf21a70c2f0b41c39024bc909509652d49d28b2dbc1083c6705e4d02d354179125491aafb9d1977ec40c2306859f71444f78bca885898dca40434c62a39565d8551789d197246ebc2649184cf1e2e465f4ec789b32b739251a951ce9136326bca431db301159e51b41f29525df22bd30d20b4372a965218ff9f865d35a1c41c48b2d61c400d19e608a1416537c25d9570c6180480f340bf5c9a34d585e49df46b7f51243534345049141629cf1da52640dbac56a9f41a39630c4583825a4a42683a56e316085954cfec910a32a47041dc9e06998309967761b71344c2f98c83a8c24c316280c9560de7628736b35cb28ad64f6c5291a93bcc614a16b39a44f622a5e77c316c44a022e565c993aec6c574de5105b970e04e1587da1c1175361dcd0a78a5bc4104300fa4e6ae40d55dc90277a8736fb696d2a764b96409cc68b1c6064e509a624fdc6a0c20d2a18c7cb75c5551c83bd6da2118343b175a5e2408019591c6a9b4de222c01ee59967bf464e2af0751e6f11062392404331b1b1363b719f0ca3619db5626002f1a6312cf2da0d38eb0b439e37e81b75be02e390e792d8c57aac600e49428c32ff3079da919cb288062fdf89c488be4cdab62e3191cddcafce31546148fe218c3c24ebdf6b29934c32ffecd3f0ca4937bc994355517ca58d6f9a8a9666c67d1c062f8b1842a16082cbea2b476158176fc31ee54a96c93740be288f8772f45a0cc47229e56d5ace7a9be1299fc1336049ae88dd303cf31746a9352ea46a85535279bae79edfd6aca80b5d37ed522cb62506d4a72f4985f36809cebab2beaed59bac549eca55267141b819a7c849c78871641902b518711d4f4c8d88e2afcc3cca084318981b81d4f91ed28bb5380c3880f10f5370b019b268414ef78b8be4944541e0f5062b63c392a8a89209e2194e53482b4fddd82706d8e9a339632bdeb3341898ae406a18e602d6303892c0f234703ca3dbcc0d36f72827f1e258fecde1c8336c4496aaece673821b46553c181df618687d2b8b181786172b55d9c2102bc81c346c91391a512919e0ea0c9df297ad3e09505437b1d45486e5147d155054165ac422b2680b652ca20a8b2884003bc2be7541ae4f5891cb3e8648a579982a2ef438e19c4a881dc90dcb105da48721f455083a45457d40039c4c00483e8ef02f2e86448b10d1928c7ecd8e807c2b042f322147cde18f1837d090df48a595191e8f1e02890b2819154adaa141053ae3511a33c4085b0ca3109aa351fe84a1af913c4483591a863e08224a0bedd190f3c8440c5610cbdb40a535021ac62a03c723626c0d793cba259506928c5dc6251fcf5a520c60b0995509ae7fbffe0a51b0628548a0c0cd7687e29f8d864810c94143a0014c06cef8e599cf103013def90ea98e3525d0e9cb16f420a430a7449076d28e51fa2054006040a88f180f865cc10424bf5345947e710b07e0a66d4669bc8012a4a6ed0c2043f26480157c6c86de24c60585f1a19150504b9503401530d1cf8d98ca2012849c5c440ab730f4a273b16ad370625527184a532e555b8101602718307d024c15e11fffe0390f9149cd6ab3834aaa9cb5c7aef2d4a74cdac810733acd834c3013c601c00a0e00cc300c6312df845e12a7e437c9ddc0a763e5d7186d5411e3e9a39d1d8bc10148aaaf961a4f58f491a64bb9221731c0805f2ab058186847b88b38af842a20fe2cbf08155aac823656d0732995f20400cd5e0c76fb231b46de09587df596b321f29a96bce7d5e6bc502e68b1986f637a002af40c972781481846caafdef6d63ecd6a49159571bff295ebab22d9aec5363bd20384612768e026bf483a5b7bc915220084a1246ee2bd2fb2a56abd256c0cb6a0820024a5b7b18d2d0c525b8584dd8011b14c187b62f44d7a504cac2b386d0c0080977f8c745f30182c4935bc822af46bb679db82185c244ba7dce0b8311d2b87f1f261ee8278b3ece5ec880fe03142f9585fa88d418709725a920ab8a7199eef48079bda796658bafd0a03820f30e48300600b5ba0028e314c581e1b77c331d52c67fbb50f0354b92255d0c24d167c7a651808b8695f9ea7ce7aeab1159cd92285f8079db7f0e12b17a25fbd8d4121f2a5af45bcf7ce2831b316b649e7426c97a4bddd822116fd8f3c231a2c31d8070034bdcd7d649a0a770e08003b}]]
}

proc gui::About {} {
	variable pady
	catch {
		destroy .about
	}
	toplevel .about
	pack [ttk::frame .about.frame_about]
	pack [ttk::label .about.frame_about.author -text "[::msgcat::mc gui_msg_about_author]: Pythonbrad"] -pady $pady
	pack [ttk::frame .about.frame_about.siteweb]
	pack [ttk::label .about.frame_about.siteweb.siteweb_text -text "Siteweb:"] -pady $pady -side left
	pack [ttk::label .about.frame_about.siteweb.siteweb_value -text "http://pythonbrad.pythonanywhere.com" -foreground green] -pady $pady -side left
	pack [ttk::frame .about.frame_about.email]
	pack [ttk::label .about.frame_about.email.email_text -text "Email:"] -pady $pady -side left
	pack [ttk::label .about.frame_about.email.email_value -text "fomegnemeudje@outlook.com" -foreground green] -pady $pady -side left
	pack [ttk::frame .about.frame_about.source]
	pack [ttk::label .about.frame_about.source.source_text -text "Data source:"] -pady $pady -side left
	pack [ttk::label .about.frame_about.source.source_value -text "http://resulam.com" -foreground green] -pady $pady -side left
	pack [ttk::frame .about.frame_about.version]
	pack [ttk::label .about.frame_about.version.version_text -text "Version:"] -pady $pady -side left
	pack [ttk::label .about.frame_about.version.version_value -text [package versions learn_mala] -foreground green] -pady $pady -side left
}
proc gui::Pub {} {
	Clean
	variable pady
	variable img_ext
	variable img_dir
	lm_addons::Img_auto_resize_and_set $img_dir/[string totitle regarder].$img_ext
	pack [ttk::label .frame.img_pub -image img_temp] -pady $pady
	pack [text .frame.pub -bg black] -pady $pady
	.frame.pub tag configure green -foreground green
	.frame.pub tag configure orange -foreground orange
	.frame.pub tag configure blue -foreground blue
	.frame.pub insert end [::msgcat::mc gui_msg_about_resulam]\n green
	.frame.pub insert end [::msgcat::mc gui_msg_recommandation]\n orange
	.frame.pub insert end [::msgcat::mc gui_msg_mysiteweb]\n orange
	.frame.pub insert end [::msgcat::mc gui_msg_myblog]\n orange
	.frame.pub insert end [::msgcat::mc gui_msg_myemail]\n orange
	.frame.pub insert end [::msgcat::mc gui_msg_contribution]\n orange
	.frame.pub tag configure cyan -foreground cyan
	.frame.pub insert end [::msgcat::mc gui_msg_citation1]\n cyan
	.frame.pub insert end [::msgcat::mc gui_msg_citation2]\n cyan
	.frame.pub configure -height 10
	pack [ttk::button .frame.close -text [::msgcat::mc gui_msg_pub_close] -command "gui::Choose_language"]
}
proc gui::Choose_language {} {
	Clean
	variable widget_temp
	variable pady
	variable img_ext
	variable img_dir
	lm_addons::Img_auto_resize_and_set $img_dir/[string totitle bavarder].$img_ext
	pack [ttk::label .frame.img_home -image img_temp] -pady $pady
	pack [ttk::label .frame.title -text "Learn Mala"] -pady $pady
	pack [ttk::label .frame.question -text [::msgcat::mc gui_msg_choose_lang]] -pady $pady
	pack [ttk::combobox .frame.listlanguage -values [lgm::Get_listlang] -state readonly] -pady $pady
	set widget_temp .frame.listlanguage
	pack [ttk::button .frame.valid -text [::msgcat::mc gui_msg_valided] -command "
		set lang \[.frame.listlanguage get\]
		if {\$lang != {}} then {
			lgm::Language \$lang
			gui::Home
		}
	"] -pady $pady
}
proc gui::Home {} {
	Clean
	variable pady
	variable img_ext
	variable img_dir
	lm_addons::Img_auto_resize_and_set $img_dir/[string totitle aller].$img_ext
	pack [ttk::button .frame.previous -text [::msgcat::mc gui_msg_change_lang] -command "gui::Choose_language"] -pady $pady
	pack [ttk::label .frame.title -text [format [::msgcat::mc gui_msg_welcome] [lgm::Language] [lgm::Info [lgm::Language] size] [lgm::Info [lgm::Language] size_audio]]] -pady $pady
	pack [ttk::label .frame.img_start -image img_temp] -pady $pady
	pack [ttk::label .frame.message -text [lm_addons::Fullconcat [lgm::Translate_text "Je Apprendre [lgm::Language]"]]] -pady $pady
	pack [ttk::label .frame.message2 -text [format [::msgcat::mc gui_msg_intro] [lgm::Language]]] -pady $pady
	pack [ttk::button .frame.start -text [::msgcat::mc gui_msg_start] -command "gui::Choose_level"] -pady $pady
}
proc gui::Choose_level {} {
	Clean
	variable pady
	pack [ttk::button .frame.previous -text [::msgcat::mc gui_msg_home] -command "gui::Home"] -pady $pady
	pack [ttk::label .frame.title -text [::msgcat::mc gui_msg_choose_level]] -pady $pady
	pack [ttk::button .frame.level0 -text [::msgcat::mc gui_msg_level0] -command "
		lgm::Level 0
		gui::Start
	"] -pady $pady
	pack [ttk::button .frame.level1 -text [::msgcat::mc gui_msg_level1] -command "
		lgm::Level 1
		gui::Start
	"] -pady $pady
	pack [ttk::button .frame.level2 -text [::msgcat::mc gui_msg_level2] -command "
		lgm::Level 2
		gui::Start
	"] -pady $pady
	pack [ttk::button .frame.level3 -text [::msgcat::mc gui_msg_level3] -command "
		lgm::Level 3
		gui::Start
	"] -pady $pady
	pack [ttk::button .frame.level4 -text [::msgcat::mc gui_msg_level4] -command "
		lgm::Level 4
		gui::Start
	"] -pady $pady
	if [lgm::Info [lgm::Language] has_audio] then {
		pack [ttk::button .frame.level5 -text [::msgcat::mc gui_msg_level5] -command "
			lgm::Level 5
			gui::Start
		"] -pady $pady
		pack [ttk::button .frame.level6 -text [::msgcat::mc gui_msg_level6] -command "
			lgm::Level 6
			gui::Start
		"] -pady $pady
		pack [ttk::button .frame.level7 -text [::msgcat::mc gui_msg_level7] -command "
			lgm::Level 7
			gui::Start
		"] -pady $pady
	}
}
proc gui::Start {} {
	Clean
	variable pady
	variable img_ext
	variable img_dir
	pack [ttk::button .frame.previous -text [::msgcat::mc gui_msg_change_level] -command "gui::Choose_level"] -pady $pady
	pack [ttk::label .frame.score -text "score: [lgm::Score]"] -pady $pady
	if {[lgm::Level] in "0 5"} then {
		destroy .frame.score
		pack [ttk::label .frame.message -text [lgm::Ask]] -pady $pady
		if {[lgm::Level] == 5} then {
			lm_addons::Img_auto_resize_and_set "$img_dir/[string totitle parler].$img_ext"
			pack [ttk::label .frame.img_start -image img_temp] -pady $pady
			pack [ttk::button .frame.playsound -text [::msgcat::mc gui_msg_repeat] -command {
				lgm::Playsound [lgm::Get_sound_to_play]
			}]
		}
		pack [ttk::frame .frame.frame_button]
		pack [ttk::button .frame.frame_button.word_previous -text [::msgcat::mc gui_msg_previous] -command "
			lgm::Whole -1
			.frame.message configure -text \[lgm::Ask\]
		"] -pady $pady -padx $pady -side left
		pack [ttk::button .frame.frame_button.word_next -text [::msgcat::mc gui_msg_next] -command "
			lgm::Whole 1
			.frame.message configure -text \[lgm::Ask\]
		"] -pady $pady -padx $pady -side right
	} elseif {[lgm::Level] in "1 2 6 7"} then {
		pack [ttk::label .frame.message -text [lgm::Ask]] -pady $pady
		if {[lgm::Level] == 1} then {
			lm_addons::Img_auto_resize_and_set "$img_dir/[string totitle [lgm::Get_answer]].$img_ext"
		} elseif {[lgm::Level] == 2} then {
			lm_addons::Img_auto_resize_and_set "$img_dir/no_img.$img_ext"
		} elseif {[lgm::Level] in "6 7"} then {
			lm_addons::Img_auto_resize_and_set "$img_dir/[string totitle parler].$img_ext"
		}
		pack [ttk::label .frame.img_start -image img_temp] -pady $pady
		if {[lgm::Level] in "6 7"} then {
			pack [ttk::button .frame.playsound -text [::msgcat::mc gui_msg_repeat] -command {
				lgm::Playsound [lgm::Get_sound_to_play]
			}]
		}
		pack [ttk::frame .frame.frame_button]
		set pos [lm_addons::Shuffle left right]
		pack [ttk::button .frame.frame_button.word_false -text [msgcat::mc [lgm::Get_random_word]] -command "
			lgm::Score -1
			.frame.info configure -text {[format [::msgcat::mc gui_msg_answer_false] [msgcat::mc [lgm::Get_answer]]]}  -foreground red
			pack \[ttk::button .frame.continuous -text [::msgcat::mc gui_msg_continuous] -command {gui::Start}\] -pady $pady
			.frame.frame_button.word_false configure -state disable
			.frame.frame_button.word_true configure -state disable
		"] -pady $pady -padx 5 -side [lindex $pos 0]
		pack [ttk::button .frame.frame_button.word_true -text [msgcat::mc [lgm::Get_answer]] -command "
			lgm::Score 1
			.frame.info configure -text {[::msgcat::mc gui_msg_answer_true]}  -foreground green
			pack \[ttk::button .frame.continuous -text [::msgcat::mc gui_msg_continuous] -command {gui::Start}\] -pady $pady
			.frame.frame_button.word_false configure -state disable
			.frame.frame_button.word_true configure -state disable
		"] -pady $pady -padx 5 -side [lindex $pos 1]
	} elseif {[lgm::Level] in "3 4"} {
		pack [ttk::label .frame.message -text [lgm::Ask]] -pady $pady
		if {[lgm::Level] == 3} then {
			pack [ttk::label .frame.indice -text [lm_addons::Hangman [msgcat::mc [lgm::Get_answer]]]] -pady $pady
		}
		pack [ttk::entry .frame.entry] -pady $pady
		set i 0
		set frame_answer ""
		set nb_block 3
		set answer [lgm::Get_answer]
		set answer_for_gui [msgcat::mc $answer]
		if {[llength [lgm::Get_answer]] > 1} then {
			set use_word 1
			set _ ""
			set random_word [lgm::Get_random_word 3]
			set random_word_for_gui ""
			foreach e $random_word {
				lappend random_word_for_gui [msgcat::mc $e]
			}
			puts $random_word_for_gui
			foreach e "$answer_for_gui $random_word_for_gui" {
				if {[lsearch $_ $e] == -1} then {
					lappend _ $e
				}
			}
		} else {
			set use_word 0
			set _ ""
			foreach e "[split $answer_for_gui {}] [lm_addons::Random_choice [split abcdefghijklmnopqrstuvwxyz {}] 3]" {
				if {[lsearch $_ $e] == -1} then {
					lappend _ $e
				}
			}
		}
		set _ [eval lm_addons::Shuffle $_]
		if $use_word then {
			lappend _ { }
		}
		foreach e $_ {
			if {[expr $i % $nb_block] == 0} {
				set frame_answer [ttk::frame .frame.frame_answer$i]
				pack $frame_answer
			}
			pack [ttk::button $frame_answer.button_answer_[expr $i % $nb_block] -text $e -command "
				.frame.entry insert end {$e}
			"] -side left
			incr i
		}
		pack [ttk::button .frame.button_backspace -text [::msgcat::mc gui_msg_delete] -command "
			set _ \[.frame.entry get\]
			.frame.entry delete 0 end
			.frame.entry insert 0 \[lrange \$_ 0 end-1\]
		"]
		pack [ttk::button .frame.valid -text [::msgcat::mc gui_msg_valided] -command "
			set entry \[.frame.entry get\]
			if {\$entry == {$answer_for_gui}} {
				lgm::Set_entry {$answer}
			}
			if \[lgm::Verify\] then {
				lgm::Score 1
				.frame.info configure -text {[::msgcat::mc gui_msg_answer_true]} -foreground green
			} else {
				lgm::Score -1
				.frame.info configure -text {[format [::msgcat::mc gui_msg_answer_false] $answer_for_gui]} -foreground red
			}
			pack \[ttk::button .frame.continuous -text [::msgcat::mc gui_msg_continuous] -command {gui::Start}\] -pady $pady
			.frame.valid configure -state disable
		"] -pady $pady
	}
	pack [ttk::label .frame.info -text ""]
}
proc gui::Clean {} {
	variable widget_temp
	lgm::Clean_temp
	set widget_temp ""
	variable pady
	if [catch {
		destroy .frame
		pack [ttk::frame .frame]
	} err] {
		puts $err
	}
}
proc gui::Test {} {
	set lang_test Ghomala
	set test_log ""
	msgcat::mclocale en
	set t [clock seconds]
	
	wm attributes . -disabled 1
	update
	if [catch {
		foreach e [list "Aller" "Je t'aime" "Banane malax\u00e9e" "H\u00e9risson"] {
			if {$e == [msgcat::mc $e]} {
				set error_msg "{$word} has not been translated"
				if [tk_messageBox -type yesno -icon error -title "Translation error" -message "Cancel Test?" -detail $error_msg] {
					exit
				} else {
					error $error_msg
				}
			}
		}
		lappend test_log "Test translate: OK\n"
	} err] {
		lappend test_log "Test translate: failed\n"
		lappend test_log "Test translate error: $err\n"
	}
	if [catch {
		Pub
		update
		.frame.close invoke
		update
		.frame.listlanguage set $lang_test
		update
		.frame.valid invoke
		update
		.frame.previous invoke
		update
		.frame.listlanguage set $lang_test
		update
		.frame.valid invoke
		update
		.frame.start invoke
		update
		.frame.previous invoke
		update
		.frame.start invoke
		update
		foreach level {0 1 2 3 4 5 6} {
			.frame.level$level invoke
			switch $level {
				0 {
					time {
						update
						.frame.frame_button.word_next invoke
					} 2000
					time {
						update
						.frame.frame_button.word_previous invoke
					} 2000
				}
				1 {
					time {
						update
						time {.frame.frame_button.word_false invoke} 2
						.frame.continuous invoke
					} 200
					time {
						update
						time {.frame.frame_button.word_true invoke} 2
						.frame.continuous invoke
					} 200
				}
				2 {
					time {
						update
						time {.frame.frame_button.word_false invoke} 2
						.frame.continuous invoke
					} 100
					time {
						update
						time {.frame.frame_button.word_true invoke} 2
						.frame.continuous invoke
					} 100
				}
				3 {
					time {
						update
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						.frame.entry insert 0 [lgm::Get_random_word]
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						.frame.entry insert 0 [lgm::Get_answer]
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
				}
				4 {
					time {
						update
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						.frame.entry insert 0 [lgm::Get_random_word]
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						.frame.entry insert 0 [lgm::Get_answer]
						time {.frame.valid invoke} 2
						.frame.continuous invoke
					} 50
				}
				5 {
					time {
						update
						.frame.frame_button.word_next invoke
					} 2000
					time {
						update
						.frame.frame_button.word_previous invoke
					} 5000
				}
				6 {
					time {
						update
						time {.frame.playsound invoke} 2
						time {.frame.frame_button.word_false invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						time {.frame.playsound invoke} 2
						time {.frame.frame_button.word_true invoke} 2
						.frame.continuous invoke
					} 50
				}
				7 {
					time {
						update
						time {.frame.playsound invoke} 2
						time {.frame.frame_button.word_false invoke} 2
						.frame.continuous invoke
					} 50
					time {
						update
						time {.frame.playsound invoke} 2
						time {.frame.frame_button.word_true invoke} 2
						.frame.continuous invoke
					} 50
				}
				default {}
			}
			.frame.previous invoke
		}
		lappend test_log "Test gui: OK\n"
	} err] {
		lappend test_log "Test gui: failed\n"
		lappend test_log "Test gui error: $err\n"
	}
	tk_messageBox -message "Run in [expr [clock seconds]-$t] seconds" -icon info -detail $test_log
	Pub
	wm attributes . -disabled 0
}