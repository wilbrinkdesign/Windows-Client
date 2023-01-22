### Enable .NET Framework

```powershell
dism /online /Enable-Feature /featurename:NetFx3 /All /Source:<disk>\sources\sxs /LimitAccess
```

### Enable Telnet

```powershell
dism /online /Enable-Feature /FeatureName:TelnetClient
```
