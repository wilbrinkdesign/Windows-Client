$file = Get-Item "D:\Map 1\Projects" ; $file.LastWriteTime = (Get-Date)
dir <folder> -R | foreach { $_.LastWriteTime = [System.DateTime]::Now }