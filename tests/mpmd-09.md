<# recursion #>&
$mode{user "<%" ">" "\B" "\B" "\W>" "<" ">" "$" ""}&
$mode{meta user}&
<%define countdown
<%if $1>&
$1...
<%define _countdown <%countdown $1>>&
<%else>&
Done!
<%define _countdown>&
<%endif>&
<%_countdown <%eval $1-1>>&
>&
<%countdown 10>&
<#
vim:ts=4:sw=4:ai:et:fileencoding=utf8:syntax=perl
#>&
