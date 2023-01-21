<#
    .DESCRIPTION
    Dit Backup Onedrive.ps1 script zorgt ervoor dat de OneDrive veilig wordt gesteld 
    middels robocopy op een externe schijf. Je krijgt de optie om alles te overschrijven 
    of om een nieuwe map te maken zodat het archief blijft bestaan en je altijd terug 
    kunt naar een vorige versie.
    
    .NOTES
    Author:   Mark Wilbrink
    Created:  26-7-2022
    Modified: 7-8-2022
#>

Function Backup-OneDrive
{
    Clear-Host

    # Check of OneDrive uberhaupt is ingesteld
    If (!($env:OneDrive))
    {
        Write-Host "OneDrive is niet ingesteld" -ForegroundColor Red
        Break
    }

    # Vraag alle externe schijven op waar naar gekopieerd kan worden
    Write-Host "Externe schijven worden opgevraagd. Een ogenblik geduld a.u.b." -ForegroundColor Yellow
    $HashTableSchijven = @{}
    $HashTableSchijvenVullen = Get-Partition | where { $_.IsBoot -eq $False -and $_.DriveLetter } | Get-Volume | where { $_.Size } | ForEach-Object { $HashTableSchijven += @{$_.DriveLetter = $_.FileSystemLabel} }

    Clear-Host

    If (!($HashTableSchijven.GetEnumerator()).count)
    {
        Write-Host "Er zijn geen externe schijven gevonden voor de back-up" -ForegroundColor Red
        Break
    }
    ElseIf (($HashTableSchijven.GetEnumerator()).count -gt 1)
    {
        # Als er meerdere externe schijven gevonden zijn, laat de gebruiker dan kiezen
        Get-Partition | where { $_.IsBoot -eq $False -and $_.DriveLetter } | Get-Volume
        Write-Host ""
        Do { $PadExterneSchijf = Read-Host "Geef de driveletter op van de externe schijf waar de back-up op geplaatst moet worden" } Until (($PadExterneSchijf -ne "C:") -and ((Test-Path -Path $PadExterneSchijf) -eq $True))
    }
    Else
    {
        # Vraag de enige externe schijf op en zet deze weg in een variabel
        $PadExterneSchijf = "$($HashTableSchijven.GetEnumerator().Name):"
    }

    Clear-Host

    # We hebben opties tijdens het kopieren
    Write-Host "1. Ja, overschrijven" -ForegroundColor Yellow
    Write-Host "2. Nee, nieuwe map en kopieren" -ForegroundColor Yellow
    Write-Host ""
    Do { $Overschrijven = Read-Host "Wil je de vorige back-up overschrijven van '$PadExterneSchijf'?" } While ( $Overschrijven -notmatch "^[1-2]$" )
    $Overschrijven = If ($Overschrijven -eq 1) { "Ja" } ElseIf ($Overschrijven -eq 2) { "Nee" }
    If ($Overschrijven -eq "Ja") { $PadExterneSchijf = "$PadExterneSchijf\Backup" } Else { $PadExterneSchijf = "$PadExterneSchijf\$(Get-Date -Format "yyyy-MM-dd")" }
    
    Clear-Host

    Write-Host "De inhoud van '$($env:OneDrive)' zal worden gekopieerd naar '$PadExterneSchijf'"  -ForegroundColor Yellow

    Write-Host ""
    Write-Host "1. Ja" -ForegroundColor Yellow
    Write-Host "2. Nee" -ForegroundColor Yellow
    Write-Host ""
    Do { $Doorgaan = Read-Host "Doorgaan?" } While ($Doorgaan -notmatch "^[1-2]$")
    $Doorgaan = If ($Doorgaan -eq 1) { "Ja" } ElseIf ($Doorgaan -eq 2) { "Nee" } 

    If ($Doorgaan -eq "Nee")
    {
        Break
    }

    Clear-Host

    Write-Host "De inhoud van '$($env:OneDrive)' wordt nu gekopieerd naar '$PadExterneSchijf'"  -ForegroundColor Yellow
    robocopy $env:OneDrive $PadExterneSchijf /E /R:0 /MIR /A-:SH /XD "System Volume Information" "`$RECYCLE.BIN" /XF "desktop.ini"
}