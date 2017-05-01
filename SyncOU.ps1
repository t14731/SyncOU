<#	
	.NOTES
	===========================================================================
	 .SYNOPSIS
     OU-Import Utility
     .DESCRIPTION
     Import OU's that are Exported from a different domain
     .OUTPUTS
     [String]$file = "C:\Temp\domain.csv" - This should be changed in accordance to what exported
	 Created on:   	2/2/2017 1:20 PM
	 Created by:   	JB027934
	 Organization: 	CTS
	 Filename:      Sync-OU.ps1 
     Version: 1.0
    
	
	

   ===========================================================================
#>

<#
	
    ===========================================================================
   .Export Script located at: 

   .CSV Example top line is the header, Will have OU and Linked GPO's
    OU,GPO
   "OU=Domain Controllers,DC=LCAHNCRKC,DC=net",STIG CWx - DOD Certficates



	===========================================================================
#>


$OFS = ','
$domain = (get-addomain).Distinguishedname
[String]$file = "C:\Temp\LCAHNCRKC.csv"
[Array]$data = ""
[array]$data = import-csv -Path $file
[array]::Reverse($data)

foreach($line in $data){
    #Write-host $line -ForegroundColor Yellow
    $line = $line.replace(",$DNSourceDomain","")
    #write-host $line -ForegroundColor green
    [Array]$splitmereverse = $line -split $OFS
    [array]::Reverse($splitmereverse)
    #write-host $splitmereverse -ForegroundColor Cyan # OU=Admin OU=Servers OU=2016 R1 OU=test OU=test2 OU=test3 OU=test4


    #Write-host $line.OU -ForegroundColor Yellow
    #write-host $splitmereverse.Count -ForegroundColor green
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



     

} #ending for

write-host "End of CSV file" -ForegroundColor Green
