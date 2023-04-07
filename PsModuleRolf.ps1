Function Remove-InactiveAccounts {
    <#
    .SYNOPSIS
    Removes user accounts that have not been used in a specified number of days.

    .DESCRIPTION
    The function uses the LastUseTime property of each user profile to determine whether the account has not been used in a specified number of days. If an account has not been used in the specified time period, the associated registry keys for the profile and home folder are removed.

    .PARAMETER Days
    Specifies the number of days after which a user account should be considered inactive. The default value is 180 days.

    .EXAMPLE
    Remove-InactiveAccounts -Days 90
    Removes user accounts that have not been used in the last 90 days.

    .NOTES
    Author: [Your Name]
    Date: [Date]
    Version: 2.0
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int]$Days = 180
    )

    $DaysFilterAccounts = (Get-Date).AddDays(-$Days).ToString("yyyyMMdd")

    $InactiveAccounts = Get-CimInstance -Class Win32_UserProfile -Filter "Special = 'False' AND Loaded = 'False'" |
    Where-Object { $_.LastUseTime -le $DaysFilterAccounts }

    if ($InactiveAccounts) {
        foreach ($account in $InactiveAccounts) {
            $sid = $account.SID
            $path = $account.LocalPath
            Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$sid" -Recurse -Force
            Remove-Item -Path $path -Recurse -Force
            Write-Output "Removed user account $sid"
        }
    } else {
        Write-Output "No inactive accounts found"
    }
}

Export-ModuleMember -Function Remove-InactiveAccounts