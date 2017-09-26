$nic1 = Get-AzureRmNetworkInterface -Name Nic1 -ResourceGroupName TestRG
$cred = Get-Credential

$VirtualMachine = New-AzureRmVMConfig -VMName "VM1" -VMSize "Standard_D2"

$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName "Server1" -Credential $cred

$VirtualMachine = Set-AzureRmVMSourceImage -VM $VirtualMachine -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2016-Datacenter" -Version "latest"

$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name "VM1-OSDisk.vhd" -VhdUri "https://mccmstorageaccount.blob.core.windows.net/vhds/VM1-OSDisk.vhd" -CreateOption FromImage  -Caching ReadWrite -Windows

$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -NetworkInterface $nic1

New-AzureRmVM -VM $VirtualMachine -ResourceGroupName TestRG -Location eastus