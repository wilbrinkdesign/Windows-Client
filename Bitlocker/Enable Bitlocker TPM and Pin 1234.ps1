manage-bde -protectors -delete "C:" -type tpm
manage-bde -protectors -delete "C:" -type tpmandpin
manage-bde -protectors -delete "C:" -type password
manage-bde -protectors -delete "C:" -type recoverypassword
manage-bde -off C:

Do
{
    sleep -s 5

    $VolumeStatus = (Get-BitLockerVolume C:).VolumeStatus
} While ($VolumeStatus -eq "DecryptionInProgress")

Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -RecoveryPasswordProtector -UsedSpaceOnly
$pin = ConvertTo-SecureString "1234" -AsPlainText -Force
Add-BitlockerKeyProtector -Mountpoint "C:" -Pin $pin -TpmAndPinProtector
