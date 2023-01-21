$wu_search = New-Object -ComObject "Microsoft.Update.Searcher"
$wu_history = $wu_search.GetTotalHistoryCount()
$windowsupdates = $wu_search.QueryHistory(0,$wu_history)
$hotfixes = Get-HotFix

$hash_updates = @{}

Foreach ($hotfix In $hotfixes)
{
    $titel = $hotfix.HotFixID -match "KB\d+"

    If (!$hash_updates.ContainsKey($matches[0]))
    {
        $global:hash_updates += @{$matches[0] = $hotfix.InstalledOn}
    }
}

Foreach ($windowsupdate In $windowsupdates)
{
    $titel = $windowsupdate.Title -match "KB\d+"

    If (!$hash_updates.ContainsKey($matches[0]))
    {    
        $global:hash_updates += @{$matches[0] = $windowsupdate.Date}
    }
}

$hash_updates
