package provide learn_mala 1.0
package require msgcat

msgcat::Init
set msg_dir [file dirname [info script]]/msgs
set msgs [glob $msg_dir/*.msg]

foreach msg $msgs {
	source $msg
}

set local $msg_dir/[lindex [split [msgcat::mclocale] _] 0]
if ![file exists $local.msg] {
	msgcat::mclocale en
}
unset local
unset msgs
unset msg_dir

wm attributes . -fullscreen 1
set ::autoajust::useautoajust 1

after 1000 autoajust::AutoAjust .

namespace eval ::learn_mala {
	proc ::learn_mala::start {} {
		gui::Pub
	}
	proc ::learn_mala::test {} {
		gui::Test
	}
}
