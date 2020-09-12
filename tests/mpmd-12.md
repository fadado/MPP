#| "partial" user macro |#&
#|######################################################################
# ${partial filename arg...}
#
# Like include but passing (up to 8) parameters to the included file.
#|#&
${mode quote "~"}&
${define partial
    ${defeval __partial
        ~${defeval __partial
            ~${mode quote}~${include $1}~${mode quote "~"}}
    }${__partial}${__partial $2 $3 $4 $5 $6 $7 $8 $9
    }${undef __partial}
}&
${partial youtube.html 7zIoLvbCCm8 420 315}&
#|
vim:ts=4:sw=4:ai:et:fileencoding=utf8:syntax=perl
|#&
