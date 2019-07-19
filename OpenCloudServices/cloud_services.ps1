
# TASK 3
# 
# Deploy through the portal
#   - ResourceGroup RG2_IaaS
#   - Virtual Network + Subnet
#   - Network Security Group (Filter everything except 3389)
#   - Windows Vm
#   - Attach a Public IP on the VM


#Import-module -Name Azurerm
#Get-module

## Login to Azure
Login-AzureRMAccount

## Common variables
$GroupName = "RG3_IaaS"
$Location = "South Central US"
$VirtualNetworkName = "vn3"
$AddressVNPrefix = "10.0.0.0/16"
$AddressSNPrefix = "10.0.1.0/24"
$SecurytyGroup = "SecureNetwork3"

##
## Create a Resource Group
$vnet = New-AzureRmResourceGroup $groupName -Location $Location

## Create the Subnet

## Config
$Subnet = New-AzureRmVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix $AddressSNPrefix
## Creation
$vnet = New-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $GroupName -Location $Location -AddressPrefix $AddressVNPrefix -Subnet $Subnet

##
## Security Group
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $GroupName -Location $Location -Name $SecurytyGroup -SecurityRules $rule3389

##
$nic = New-AzureRmNetworkInterface -Name "NetworkInterface1" -ResourceGroupName $GroupName -Location $Location -SubnetId $vnet.Subnets[0].Id  -NetworkSecurityGroupId $SecurityNetworkName.Id


##credentials 

$uservm = "-----"
$pass =  ConvertTo-SecureString -String "*****" -AsPlainText -Force

$Credential = New-Object System.Management.Automation.PSCredential ($uservm, $pass);

# Settings

$vmName = "vmtask3"
$VmSize = "Standard_A1"
$ComputerName = "RuthComputer"

$Virtualmachine = New-AzureRmVMConfig -VMName $vmname -VMSize $VmSize

$Virtualmachine = Set-AzureRmVMOperatingSystem -VM $Virtualmachine -Windows -ComputerName $ComputerName -Credential $Credential

$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $Virtualmachine -Id $nic.Id

$Virtualmachine = Set-AzureRmVMSourceImage -VM $Virtualmachine  -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"  -Skus "2016-Datacenter" -Version "latest"

  # Create the VM.
New-AzureRmVM -ResourceGroupName $GroupName -Location $Location -VM $Virtualmachine