Write-Host "Status opvragen voordat we beginnen met verwijderen..."
manage-bde -status C:

manage-bde -protectors -delete "C:" -type tpm
manage-bde -protectors -delete "C:" -type tpmandpin
manage-bde -protectors -delete "C:" -type password
manage-bde -protectors -delete "C:" -type recoverypassword
manage-bde -off C:

Write-Host "Status opvragen nadat we alle protectors hebben verwijderd..."
manage-bde -status C:

Do
{
    sleep -s 5

    $VolumeStatus = (Get-BitLockerVolume C:).VolumeStatus
} While ($VolumeStatus -eq "DecryptionInProgress")

Write-Host "Bitlocker inschakelen..."
Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -RecoveryPasswordProtector -UsedSpaceOnly

Write-Host "Bitlocker TPM + PIN instellen..."
$pin = ConvertTo-SecureString "1234" -AsPlainText -Force
Add-BitlockerKeyProtector -Mountpoint "C:" -Pin $pin -TpmAndPinProtector

Write-Host "Status opvragen nadat we klaar zijn..."
manage-bde -status C:
