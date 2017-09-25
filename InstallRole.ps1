# Instala uma Função/Recurso do Windows Server, recebendo o nome da Função/Recurso como parâmetro
Param
 (
    $Role
 )
$isInstalled = Get-WindowsFeature -Name $role

if ($isInstalled.Installed -eq $false)
{
    Install-WindowsFeature -Name $role -IncludeAllSubFeature -IncludeManagementTools    
}
