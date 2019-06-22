package provide learn_mala 1.0
package require snack

namespace eval ::lgm {
	variable var_language none
	variable var_level 0
	variable temp ""
	variable var_score 0
	variable audio_ext mp3
	variable audio_dir [file dirname [info script]]/data/sound
	sound lgm::Player
}
proc lgm::Level {{arg_level ""}} {
	variable var_level
	if {$arg_level != ""} {
		set var_level $arg_level
	} else {
		return $var_level
	}
}
proc lgm::Language {{arg_lang ""}} {
	variable var_language
	if {$arg_lang != ""} then {
		set var_language $arg_lang
	} else {
		return $var_language
	}
}
proc lgm::Get_listlang {} {
	return [dict key $datalang::data]
}
proc lgm::Score {{i ""}} {
	variable var_score
	if {$i == ""} then {
		return $var_score
	} else {
		incr var_score $i
		if {$var_score < 0} then {
			set var_score 0
		}
	}
}
proc lgm::Translate {word {nb end}} {
	variable var_language
	set ids ""
	foreach {id value} [dict filter [dict get $datalang::data $var_language Lang] value [string totitle $word]] {
		lappend ids $id
	}
	set result ""
	set count 0
	foreach id $ids {
		lappend result [dict get $datalang::data $var_language Mlang $id]
		incr count
		if {$count == $nb} then {
			break
		}
	}
	if {$result == ""} then {
		set result $word
	}
	return $result
}
proc lgm::Translate_text text {
	set result ""
	foreach word $text {
		lappend result [lm_addons::Random_choice [Translate [string totitle $word]] 1]
	}
	return $result
}
proc lgm::Whole i {
	variable temp
	set id [dict get $temp id_word]
	incr id $i
	set nb [dict get $temp nb_word]
	if {$id >= $nb || $id <= -1} then {
		dict set temp id_word 0
	} else {
		dict incr temp id_word $i
	}
}
proc lgm::Get_random_word {{nb 1} {by_id 0}} {
	variable var_language
	if $by_id {
		return [lm_addons::Random_choice [dict keys [dict get $datalang::data $var_language Lang]] $nb]
	} else {
		return [lm_addons::Random_choice [dict values [dict get $datalang::data $var_language Lang]] $nb]
	}
}
proc lgm::Ask {} {
	variable var_level
	variable var_language
	variable temp
	variable audio_ext
	variable audio_dir
	if {$var_level == 0} then {
		variable var_language
		if ![dict exists $temp id_word] then {
			dict set temp id_word 0
		}
		if ![dict exists $temp nb_word] then {
			dict set temp nb_word [Info $var_language size]
		}
		set id_word [dict get $temp id_word]
		return [format [msgcat::mc lgm_msg_meaning] [msgcat::mc [dict get $datalang::data $var_language Lang $id_word]] $var_language [dict get $datalang::data $var_language Mlang $id_word]]
	} elseif {$var_level in "1 2 3 4"} then {
		dict set temp id_word [lgm::Get_random_word 1 1]
		dict set temp word_to_found [dict get $datalang::data $var_language Lang [dict get $temp id_word]]
		dict set temp word_entry ""
		return [format [msgcat::mc lgm_msg_ask_meaning] [dict get $datalang::data $var_language Mlang [dict get $temp id_word]]]
	} elseif {$var_level in "5 6 7"} then {
		variable var_language
		if ![dict exists $temp id_word] then {
			dict set temp id_word 0
		}
		if ![dict exists $temp sounds] then {
			set _ ""
			foreach e [glob $audio_dir/$var_language/*.$audio_ext] {
				lappend _ [string range [file tail $e] 0 end-[string length .$audio_ext]]
			}
			dict set temp sounds $_
		}
		if ![dict exists $temp nb_word] then {
			dict set temp nb_word [Info $var_language size_audio]
		}
		set id_word [dict get $temp id_word]
		set sounds [dict get $temp sounds]
		set w [string totitle [lindex $sounds $id_word]]
		set w [lm_addons::Transform_text $w]
		if {[Translate $w] != $w} then {
			set trans \n[join [Translate $w] /]
		} else {
			set trans ""
		}
		if {$var_level == 5} then {
			return [format [msgcat::mc lgm_msg_meaning_audio] [msgcat::mc [string totitle $w]] $var_language $trans]
		} elseif {$var_level in "6 7"} {
			dict set temp id_word [lm_addons::Random_choice [dict get $temp sounds] 1 1]
			dict set temp word_to_found [string totitle [lm_addons::Transform_text [lindex [dict get $temp sounds] [dict get $temp id_word]]]]
			dict set temp word_entry ""
			set w [lm_addons::Transform_text [dict get $temp word_to_found]]
			if {[Translate $w] != $w} then {
				set trans \n[join [Translate $w] /]
			} else {
				set trans ""
			}
			if {$var_level == 6} then {
				return "[msgcat::mc lgm_msg_ask_meaning_audio] \n$trans"
			} else {
				return [msgcat::mc lgm_msg_ask_meaning_audio]
			}
		}
	}
}
proc lgm::Get_sound_to_play {} {
	variable temp
	set id_word [dict get $temp id_word]
	set sounds [dict get $temp sounds]
	return [lindex $sounds $id_word]
}
proc lgm::Get_answer {} {
	variable temp
	return [dict get $temp word_to_found]
}
proc lgm::Set_entry value {
	variable temp
	return [dict set temp word_entry $value]
}
proc lgm::Verify {} {
	variable temp
	if {[string totitle [dict get $temp word_to_found]] == [string totitle [dict get $temp word_entry]]} then {
		return 1
	} else {
		return 0
	}
}
proc lgm::Clean_temp {} {
	variable temp ""
}
proc lgm::Info {lang tag} {
	variable audio_ext
	variable audio_dir
	switch $tag {
		size {
			return [dict size [dict get $datalang::data $lang Lang]]
		}
		has_audio {
			return [file exists $audio_dir/$lang]
		}
		size_audio {
			if [Info $lang has_audio] then {
				return [llength [glob $audio_dir/$lang/*.$audio_ext]]
			} else {
				return 0
			}
		}
	}
}
proc lgm::Playsound sound_name {
	variable var_language
	variable audio_ext
	variable audio_dir
	set sound_dir $audio_dir/$var_language/$sound_name.$audio_ext
	if [file exists $sound_dir] then {
		if [catch {
			lgm::Player stop
			lgm::Player read $sound_dir
			lgm::Player play
		} err] then {
			puts $err
		}
	} else {
		puts "$sound_dir not found"
	}
}