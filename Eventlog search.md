### New version: Get-EventLog

```powershll
Get-Eventlog -LogName <log> -Source <source> | Where { $_.message -like "*<text>*" }
```

### Old version: Get-WinEvent

```powershell
Get-WinEvent -LogName <log> | Where { $_.message -like '*<text>*' }
```
