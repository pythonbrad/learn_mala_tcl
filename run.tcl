lappend auto_path lib
package require learn_mala

switch [lindex $argv 0] {
	-debug {
		console show
	}
	-test {
		::learn_mala::test
	}
	default {}
}

::learn_mala::start
