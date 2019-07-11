
$wait = $true
$pathContentGenerator = '.\content_generator'

$patternSuccessful = 'Connection successful'
$patternFailed =  'Connection failed' 

cd $pathContentGenerator

## inicio el proceso
& '.\ContentGenerator.exe' $pathContentGenerator /run /exit /SilentMode 


##save the process
$process = Get-Process -Name ContentGenerator


while($wait){

    Write-Host Iniciando proceso ...
    $pathLog = '.\applog.log'
    if([System.IO.File]::Exists($pathLog)){
            Start-Sleep -Seconds 5
        $wait = $false
    }
        Start-Sleep -Seconds 2
}

## Leo el archivo y obtengo las variables 

[System.Collections.Generic.List[String]]$listLogFailed = Select-String -Path $pathLog -Pattern $patternFailed -CaseSensitive
## Mostrar 10 primeros log failed
for($i = 1
    $i -le 10
    $i++ ) {
    $listLogFailed[$i]
}

[System.Collections.Generic.List[String]]$listLogSuccess = Select-String -Path $pathLog -Pattern $patternSuccessful -CaseSensitive


Write-Host 'Log Failed: ' $listLogFailed.Count

Write-Host 'Log Success: ' $listLogSuccess.Count

## Kill process
kill $process