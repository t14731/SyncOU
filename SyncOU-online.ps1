<#	
	.NOTES
	===========================================================================
	 .SYNOPSIS
     OU-Import Utility
     .DESCRIPTION
     Syncs OU's from one forest to another.

	 Created on:   	2/2/2017 1:20 PM
	 Created by:   	JB
	 Organization: 	CTS
	 Filename:      Sync-OU-OnlineVersion.ps1 
     Modified: 4/20/2017
     Version: 1.1
    
	
	

   ===========================================================================
#>
$credentialForestFrom = (Get-Credential)
$credentialForestTo = (Get-Credential)

$SourceDomainController = Read-Host "Enter Source Domain Controller - Example DC1.sourceforest.net"
$DestinationDomainController = Read-Host "Enter Destination Domain Controller - Example - dc1.destinationforest.net"

$pdceSource = (Get-ADDomainController -Server "$SourceDomainController" -Filter {OperationMasterRoles -like 'PDCEmulator'} -Credential $credentialForestSource ).hostname
$ADNameSource = (Get-ADDomain -Server "$pdceSource" -Credential $credentialForestSource ).name

$pdceDestination = (Get-ADDomainController -Server "$DestinationDomainController" -Filter {OperationMasterRoles -like 'PDCEmulator'} -Credential $credentialForestDestination).hostname
$ADNameDestination = (Get-ADDomain -Server "$pdceDestination" -Credential $credentialForestDestination).name


Function SyncOU{
$OFS = ','
$DNSourceDomain = (get-addomain -Server $pdceSource -Credential $credentialForestSource).Distinguishedname
$DNDesinationDomain = (get-addomain -Server $pdceDestination -Credential $credentialForestDestination).Distinguishedname

[Array]$data = ""
[array]$data = (Get-ADOrganizationalUnit -SearchBase $DNSourceDomain -filter * -Server $pdceSource -Credential $credentialForestSource ).Distinguishedname
[array]::Reverse($data)
 $line = $null
[int]$i =$null

foreach($line in $data){
    #Write-host $line -ForegroundColor Yellow
    $line = $line.replace(",$DNSourceDomain","")
    #write-host $line -ForegroundColor green
    [Array]$splitmereverse = $line -split $OFS
    [array]::Reverse($splitmereverse)
    #write-host $splitmereverse -ForegroundColor Cyan # OU=Admin OU=Servers OU=2016 R1 OU=test OU=test2 OU=test3 OU=test4


    #Write-host $line.OU -ForegroundColor Yellow
    write-host $splitmereverse.Count -ForegroundColor green
    $OUCount = $splitmereverse.Count
    $DNDesinationDomain = $null
    $DNDesinationDomain = (get-addomain -Server $pdceDestination -Credential $credentialForestDestination).Distinguishedname
            foreach($_ in $splitmereverse) 
            { 
                write-host $splitmereverse[$i] -ForegroundColor Yellow
                $outarget = $splitmereverse[$i].replace("OU=",'')


       
                                    Try{
                                    
                                    $oucheck = $splitmereverse[$i]+","+$DNDesinationDomain
                                    Write-verbose $oucheck -Verbose
                                    Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore -Server $pdceDestination -Credential $credentialForestDestination
                                }

                                Catch {
                                        Write-host " OU $outarget is being created in path $DNDesinationDomain" -ForegroundColor Yellow
                                        New-ADOrganizationalUnit -Name $outarget -Path $DNDesinationDomain -Server $pdceDestination -Credential $credentialForestDestination
                                        Write-host " OU $outarget has been created  in path $DNDesinationDomain" -ForegroundColor Cyan
                                        }

    

                $i++
                $DNDesinationDomain = $oucheck

            } # End of First IF
            $i = $null
