# Clean updates die langer dan 30 dagen op het systeem staan
dism /online /Cleanup-Image /StartComponentCleanup

# Clean alle updates
dism /online /Cleanup-Image /StartComponentCleanup /ResetBase
