
VERSION, bump-version

API
========================================================================

Random sequeences (Seed?  $PID?)

URL encode using sed

button-like clics?

USE CASES
========================================================================

Abbreviatures
-------------

${define IBM 'In...}

Common code fragments
---------------------

${include header.html}
${include footer.html}

Conditional blocks
------------------

${ifdef PublishExamples}
${ifdef PublishEditorNotes}

Links
-----

Links databases:

#{include links.md}

Navigation links:

#{include menubar.md}


Hierarchical documents
----------------------

${include chapter1.md}
${include chapter2.md}
...


Inside chapters:

${include section1.md}
...

HTML snippets
-------------

${defpart youtube youtube.html}
${youtube 1 2  3 ...}

Parametrized URLs
-----------------

${define google https://www.google.com/search?q=$1}
${google search+term+words}
