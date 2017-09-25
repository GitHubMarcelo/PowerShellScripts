Param
 (
    $Role
 )
$isInstalled = Get-WindowsFeature -Name $role

if ($isInstalled.Installed -eq $false)
{
    Install-WindowsFeature -Name $role -IncludeAllSubFeature -IncludeManagementTools    
}