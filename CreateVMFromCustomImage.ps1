$nic1 = Get-AzureRmNetworkInterface -Name Nic1 -ResourceGroupName TestRG
$cred = Get-Credential

$VirtualMachine = New-AzureRmVMConfig -VMName "VM1" -VMSize "Standard_D2"

$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName "Server1" -Credential $cred

$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name "VM1-OSDisk.vhd" -VhdUri "https://mccmstorageaccount.blob.core.windows.net/vhds/VM1-OSDisk.vhd" -SourceImageUri "https://mccmstorageaccount.blob.core.windows.net/vhds/Base-W16.vhd" -CreateOption FromImage -Windows -Caching ReadWrite

$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -NetworkInterface $nic1

New-AzureRmVM -VM $VirtualMachine -ResourceGroupName TestRG -Location eastus

