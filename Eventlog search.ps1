Get-WinEvent -FilterHashTable @{Logname='Security'} | Where-Object -Property Message -Match "<username>" | Out-File C:\Temp\<username>.txt
Get-WinEvent -LogName application | Where {$_.message -like '*F-Secur*'}
Get-Eventlog -LogName Application -Source Logboek1 | Where {$_.message -like "*username:*"}
Get-Eventlog -LogName Security -Source Microsoft-Windows-Security-Auditing | Where {$_.message -like "*username*"}
Get-Eventlog -LogName Logboek1 | Where {$_.message -like "*password reset*"}
