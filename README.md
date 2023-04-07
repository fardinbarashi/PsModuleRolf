# PsModuleRolf-
PsModuleRolf is a Powershell module designed

Removes user accounts that have not been used in a specified number of days.
The function uses the LastUseTime property of each user profile to determine whether the account has not been used in a specified number of days.
If an account has not been used in the specified time period, the associated registry keys for the profile and home folder are removed.
Specifies the number of days after which a user account should be considered inactive. The default value is 180 days.

EXAMPLE
Remove-InactiveAccounts -Days 90

Removes user accounts that have not been used in the last 90 days  after which a user account should be considered inactive.

