# Load the necessary assemblies for the OpenFileDialog
Add-Type -AssemblyName System.Windows.Forms

# Create an instance of the OpenFileDialog
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog

# Set properties for the dialog
$openFileDialog.Title = "Select a ZIP File"
$openFileDialog.Filter = "ZIP Files (*.zip)|*.zip"
$openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop')

# Show the dialog and check if the user selected a file
if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $basePath = Split-Path $openFileDialog.FileName -Parent
    $folderName = [System.IO.Path]::GetFileNameWithoutExtension($openFileDialog.FileName)
    
    Expand-Archive -Path $openFileDialog.FileName -DestinationPath $basePath

    $folderPath = Join-Path -Path $basePath -ChildPath $folderName
    mongorestore.exe $folderPath

    Remove-Item -Recurse $folderPath
} else {
    # User canceled the dialog
    Write-Output "No file selected."
}

# mongorestore.exe --verbose D:\malynka\malynka_db_dump