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

[Array]$splitmereverse = $line.OU -split $OFS
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
                                    Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                }

                                Catch {
                                        Write-host " OU $outarget is being created in path $domain" -ForegroundColor Yellow
                                        New-ADOrganizationalUnit -Name $outarget -Path $domain
                                        Write-host " OU $outarget has been created  in path $domain" -ForegroundColor Cyan
                                        }



            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){
                                                        $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path =  $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+$splitmereverse[2] + "," + $domain
                            Try{
                                     Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                     }

                                Catch {
                                        Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                        New-ADOrganizationalUnit -Name $outarget -Path $path
                                        Write-host " OU $outarget has been created in path $path"-ForegroundColor Cyan
                                        }





                        } #postion 3

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path

                            Try{
                                    Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                    }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }


                        } #postion 4

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[4] + "," + $splitmereverse[3] +"," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 5

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                                $outarget = $splitmereverse[$i].replace("OU=",'')
                                $path = $splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                                $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path 
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 6

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                               $outarget = $splitmereverse[$i].replace("OU=",'')
                               $path = $splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                               $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                                Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                                }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path 
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 7

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 8

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 9

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 10

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 11

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 12

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 13

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[13] +"," + $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 14

            $i++

                    if (($i -eq $splitmereverse.GetUpperBound(0))  -or ($i -lt  $splitmereverse.GetUpperBound(0))){ 

                            $outarget = $splitmereverse[$i].replace("OU=",'')
                            $path = $splitmereverse[14] +"," + $splitmereverse[13] +"," + $splitmereverse[12] +"," + $splitmereverse[11] +"," + $splitmereverse[10] +"," + $splitmereverse[9] +"," + $splitmereverse[8] +"," + $splitmereverse[7] +"," +$splitmereverse[6] +"," +$splitmereverse[5] +"," + $splitmereverse[4] + "," + $splitmereverse[3] + "," + $splitmereverse[2] + "," + $domain 
                            $oucheck = $splitmereverse[$i]+","+ $path


                            Try{
                            Get-ADOrganizationalUnit $oucheck -ErrorAction Ignore
                            }

                            Catch {
                                    Write-host " OU $outarget is being created in path $path" -ForegroundColor Yellow
                                    New-ADOrganizationalUnit -Name $outarget -Path $path
                                    Write-host " OU $outarget has been created in path $path" -ForegroundColor Cyan
                                    }

                        } #postion 15




#Endig loop
else
{}

} # End of First IF

} #ending for

} #Ending Foreach

write-host "End of CSV file" -ForegroundColor Green
