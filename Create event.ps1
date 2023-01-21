# Windows event aanmaken in de logboeken
Write-EventLog -LogName "System" -Source "WAS" -EventID 5002 -EntryType Information -Message "Test." -Category 1 -RawData 10,20
