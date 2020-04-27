## Creator George Babudzhyan
## https://github.com/gexamb/wvd-user-automation

Param (
[string] $userUPN = “”
)
#Setting the Azure AD Tenant ID
$AADTenantID = <enter ID here>
$ConnectionName = <enter connection name here> #this will the be the name of your RunAs service principal

#Creating connection to Azure with RunAs account
$Connection = Get-AutomationConnection -Name $ConnectionName
Connect-AzAccount -ApplicationId $Connection.ApplicationId -TenantId $AADTenantId -CertificateThumbprint $Connection.CertificateThumbprint -ServicePrincipal

#Connecting to WVD tenant with Service Principal account
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -ApplicationId $Connection.ApplicationId -CertificateThumbprint $Connection.CertificateThumbprint -AADTenantId $AadTenantId

#Adding user to WVD host pools
Add-RdsAppGroupUser -TenantName <tenant> -HostPoolName <host pool> -AppGroupName "Desktop Application Group" -UserPrincipalName $userUPN
Add-RdsAppGroupUser -TenantName <tenant> -HostPoolName <host pool> -AppGroupName "Remote Application Group" -UserPrincipalName $userUPN