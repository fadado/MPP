<# code block example #>&
<%mode comment iiC "[[" "]]\n">&
[[
    <%define A Al last!>
    <%define CC $1<%A>$2>
    <%define B <%call $1$1 [ ]>>
]]
<%B C>
<#
vim:ts=4:sw=4:ai:et:fileencoding=utf8:syntax=perl
#>&
