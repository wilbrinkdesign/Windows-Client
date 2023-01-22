### Clean up Windows Updates that are installed longer than 30 days (you cannot uninstall Windows Updates older than 30 days after this action)

```powershell
dism /online /Cleanup-Image /StartComponentCleanup
```

### Clean up all Windows Updates (you cannot uninstall Windows Updates after this action)

```powershell
dism /online /Cleanup-Image /StartComponentCleanup /ResetBase
```
