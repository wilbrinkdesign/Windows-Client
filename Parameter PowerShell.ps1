# Parameter meegeven
$manager = @{ Manager = "<manager_naam>" } # New-ADUser <username> @manager => New-ADUser <username> -Manager "<manager_naam>"
$manager = @{ Manager = $True } # New-ADUser <username> @manager => New-ADUser <username> -Manager