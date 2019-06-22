package provide learn_mala 1.0
package require json

namespace eval ::datalang {
	set f [open [file dirname [info script]]/word.json rb]
	set _data [json::json2dict [read $f]]
	close $f
	unset f
	dict for {lang lang_value} $_data {
		dict for {lang_lang lang_lang_value} $lang_value {
			dict for {lang_lang_id lang_lang_id_value} $lang_lang_value {
				dict set _lang_lang [string totitle $lang_lang_id] [string totitle $lang_lang_id_value]
			}
			dict set _lang [string totitle $lang_lang] $_lang_lang
			unset _lang_lang
			unset lang_lang_id
			unset lang_lang_id_value
		}
		dict set result [string totitle $lang] $_lang
		unset _lang
		unset lang_lang
		unset lang_lang_value
	}
	unset lang
	unset lang_value
	variable data $result
	unset result
	unset _data
}