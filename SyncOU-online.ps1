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


$pdcefrom = (Get-ADDomainController -Server "testdc1.test.net" -Filter {OperationMasterRoles -like 'PDCEmulator'}).hostname
$ADNameSource = (Get-ADDomain -Server "testdc1.test.net" ).name
$pdceto = (Get-ADDomainController -Server "testdc2.test2.net" -Filter {OperationMasterRoles -like 'PDCEmulator'}).hostname
$ADNameDestination = (Get-ADDomain -Server "testdc2.test2.net").name
$credentialForestFrom = (Get-Credential)
$credentialForestTo = (Get-Credential)

$OFS = ','
$domain = (get-addomain -Server $pdceto -Credential $credentialForestTo).Distinguishedname
$domain2 = (get-addomain -Server $pdcefrom -Credential $credentialForestfrom).Distinguishedname
[Array]$data = ""
[array]$data = (Get-ADOrganizationalUnit -SearchBase $domain2 -filter * -Server $pdcefrom -Credential $credentialForestFrom ).Distinguishedname
[array]::Reverse($data)

foreach($line in $data){
Write-host $line
[Array]$splitmereverse = $line -split $OFS
[array]::Reverse($splitmereverse)
#Write-host $line.OU -ForegroundColor Yellow
        for($i = $splitmereverse.GetLowerBound(0); $i -le $splitmereverse.GetUpperBound(0)) 
        { 
            
            $i++

                    if($i -eq 2) #Start at array postion 2
                        {
                            $outarget = $splitmereverse[$i].replace("OU=",'')

                            Try{
                                    $oucheck = $splitmereverse[$i]+","+$domain
                                    Write-verbose $oucheck -Verbose
                                    Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore -Server $pdceto -Credential $credentialForestTo
                                }

                                Catch {
                                        Write-host " OU $outarget is being created in path $domain" -ForegroundColor Yellow
                                        New-ADOrganizationalUnit -Name $outarget -Path $domain -Server $pdceto -Credential $credentialForestTo
                                        Write-host " OU $outarget has been created  in path $domain" -ForegroundColor Cyan
                                        }



            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){
                                                        $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path =  $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+$splitmereverse[2] + "," + $domain
                            Try{
                                     Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore 
                                     }

                                Catch {
                                        Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                        New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                        Write-host " OU $outarget has been created in path $path"-ForegroundColor Cyan
                                        }





                        } #postion 3

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path

                            Try{
                                    Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                                    }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }


                        } #postion 4

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[4] + "," + $splitmereverse[3] +"," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 5

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 6

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                               $outarget = $splitmereverse[$i].replace("OU=",'')
                               $path = $splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                               $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 7

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 8

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 9

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 10

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 11

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 12

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 13

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[13] +"," + $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 14

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[14] +"," + $splitmereverse[13] +"," + $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -Server $pdceto -Credential $credentialForestTo -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path -Server $pdceto -Credential $credentialForestTo
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 15




#Endig loop
else
{}

} # End of First IF

} #ending for

} #Ending Foreach

write-host "End of array" -ForegroundColor Green
