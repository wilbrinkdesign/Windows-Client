ECHO Hidden files verwijderen
forfiles /S /M *.jpg /c "cmd /c del @path /s /f /a:h"