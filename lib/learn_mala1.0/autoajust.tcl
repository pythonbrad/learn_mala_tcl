package provide learn_mala 1.0

namespace eval ::autoajust {
	variable useautoajust 0
	variable widget_temp ""
	proc ::autoajust::AutoAjust {toplevel {oldsize ""}} {
		variable useautoajust
		variable widget_temp
		set size [split [lindex [split [wm geometry $toplevel] +] 0] x]
		set x 70
		if {$oldsize != $size && $useautoajust} then {
			ttk::style configure TLabel -font "Arial [expr [lindex $size 1]/$x]"
			ttk::style configure TButton -font "Arial [expr [lindex $size 1]/$x]"
			ttk::style configure TCombobox -font "Arial [expr [lindex $size 1]/$x]"
			if {$widget_temp != ""} then {
				catch {
					$widget_temp configure -font "Arial [expr [lindex $size 1]/$x]"
				}
			}
		}
		after 1000 [format {::autoajust::AutoAjust %s "%s"} $toplevel $size]
	}
}