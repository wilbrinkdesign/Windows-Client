ECHO Specifieke credentials verwijderen uit de referentie store
for /F "tokens=1,2,3 delims==" %G in ('cmdkey /list ^| findstr "teams OneDrive Office outlook"') do cmdkey /delete:%H