### Add the Hyper-V packages and at last add the feature for Windows 11

```cmd
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hv-home.txt
for /f %i in ('findstr /i . hv-home.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%i"
del hv-home.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
```