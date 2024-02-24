#!/usr/bin/osascript

# @raycast.title Set Volume
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Set volume in Music.

# @raycast.icon images/icon-volume-set.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Level" }


on run argv
	set volume output volume (item 1 of argv as integer)
end run

