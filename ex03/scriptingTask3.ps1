##------------------------------------------------------##
## List all running services
Function GetAllRuningServices{
  
    Get-Service | Where Status -eq  "Running"| Out-GridView
 
}

##------------------------------------------------------##
## Start specified service 
Function GetService {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Enter the name of the service")]
        [string]$Name
    )

     Get-Service -Name $Name
}


##--------------------------------------------------##
## Stop specified service
Function StopService {
 [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Enter the name of the service")]
        [string]$Name
    )
 
 Stop-Service -Name $Name
}

##--------------------------------------------------##
## Restart specified service
Function RestartService {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Enter the name of the service")]
        [string]$Name
    )

    Restart-Service -Name $Name
  
}

