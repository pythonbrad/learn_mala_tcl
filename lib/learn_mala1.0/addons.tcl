package provide learn_mala 1.0

namespace eval ::lm_addons {
	proc ::lm_addons::Img_auto_resize_and_set img_file {
		set gui::img_current $img_file
		set width [lindex [split [wm geometry .] "+ x"] 0]
		set height [lindex [split [wm geometry .] "+ x"] 1]
		image delete img_temp
		image create photo img_temp
		if [catch {
			image create photo _img_temp -file $img_file
		} err] then {
			image create photo _img_temp
			_img_temp copy ::tk::icons::question
		}
		puts $err
		$gui::resize_engine _img_temp [expr abs($width/4)]x[expr abs($height/4)] img_temp
	}

	proc ::lm_addons::Shuffle args {
		set _ ""
		while {$args != ""} {
			set i [expr int([llength $args] * rand())]
			lappend _ [lindex $args $i]
			set args [lreplace $args $i $i]
		}
		return $_
	}

	proc ::lm_addons::Hangman word {
		set _ $word
		for {set i 0} {$i < [string length $word]} {incr i} {
			set id [expr int([string length $word] * rand())]
			set _ [string replace $_ $id $id *]
		}
		return $_
	}

	proc ::lm_addons::Random_choice {args nb {by_id 0}} {
		set result ""
		for {set i 1} {$i <= $nb} {incr i} {
			set _ [expr int(rand()*[llength $args])]
			if $by_id then {
				lappend result $_
			} else {
				lappend result [lindex $args $_]
			}
		}
		if {$nb == 1} {
			set result [lindex $result 0]
		}
		return $result
	}

	proc ::lm_addons::Transform_text text {
		set _ [split $text ""]
		while 1 {
			set i [lsearch $_ _]
			if {$i == -1} then {
				break
			} else {
				set _ [lreplace $_ $i $i]
			}
		}
		while 1 {
			set i [lsearch $_ +]
			if {$i == -1} then {
				break
			} else {
				set _ [lreplace $_ $i $i ?]
			}
		}
		eval "set _ \[string cat $_\]"
		return $_
	}

	proc ::lm_addons::Fullconcat l {
		set _ $l
		set _ [eval concat $_]
		set _ [eval concat $_]
		set _ [eval concat $_]
		return $_
	}
}