$path = '.\myapp\applogs'

$files = Get-ChildItem $path 

ForEach($file in $files) {
    $fileName = $file.Name
    $fileType = $file.Name.Split('_')
    
    if($fileType -eq 'log') {

    Rename-Item -NewName $fileName'.log' -Path $path\$fileName 
    }
}
