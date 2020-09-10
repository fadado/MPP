#| recursion |#&
${define countdown
${if $1 > 0}&
${print $1...}&
${define _continue_countdown_ ${countdown $1}}&
${else}&
${print Done!}&
${define _continue_countdown_}&
${endif}&
${_continue_countdown_ ${eval $1 - 1}}&
}&
#| call the function |#&
${countdown 10}&
#|
vim:ts=4:sw=4:ai:et:fileencoding=utf8:syntax=perl
|#&
