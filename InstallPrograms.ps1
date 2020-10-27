
# Instala un package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Instala programas basicos

Show-Choco-Menu -Title "Instalar Firefox?" -ChocoInstall "firefox" -Description "Navegador web Open source"
Show-Choco-Menu -Title "Instalar Brave?" -ChocoInstall "brave" -Description "Navegador web basado en Chromium"
choco install 7zip.install -y

# Programacion
choco install git -y
choco install github-desktop -y
choco install python3 -y
choco install nodejs.install -y
choco install vscode -y
Show-Choco-Menu -Title "Instalar IntelliJ Idea Ultimate?" -ChocoInstall "brave" -Description "La mejor IDE para Java"
do
{
   Clear-Host
   Write-Host "================ Instalar MySQL + DBeaver + Postman? ================"
   Write-Host "S: Presionar 's' para instalar."
   Write-Host "N: Presionar 'n' para saltear."
   $selection = Read-Host "Elija una opcion:"
   switch ($selection)
   {
   's' {
        choco install mysql -y
        choco install dbeaver -y
        choco install postman -y
    }
   'n' { Break }
   }
}
until ($selection -match "s" -or $selection -match "n")

# Edicion
do
{
   Clear-Host
   Write-Host "Descripcion: Programas de edicion, GIMP para fotos, Inkscape para vectores, Blender para 3D"
   Write-Host "================ Instalar programas de edición? ================"
   Write-Host "S: Presionar 's' para instalar."
   Write-Host "N: Presionar 'n' para saltear."
   $selection = Read-Host "Elija una opcion:"
   switch ($selection)
   {
   's' {
        choco install gimp -y
        choco install inkscape -y
        choco install blender -y
    }
   'n' { Break }
   }
}
until ($selection -match "s" -or $selection -match "n")

# Comunicacion
choco install discord -y
choco install whatsapp -y
choco install microsoft-teams.install -y
Show-Choco-Menu -Title "Instalar Telegram?" -ChocoInstall "telegram.install" -Description "Plataforma de mensajes mejor que whatsapp"
Show-Choco-Menu -Title "Instalar Slack?" -ChocoInstall "slack" -Description "Plataforma de mensajes que usa Dani"

# Seguridad
choco install keepassxc -y
choco install authy-desktop -y

# Musica
choco install spotify -y
Show-Choco-Menu -Title "Instalar MusicBee?" -ChocoInstall "musicbee" -Description "Reproductor de musica, uno de los mejores"

# Juegos
choco install steam -y
choco install epicgameslauncher -y

# Backup
choco install google-backup-and-sync -y

function Show-Choco-Menu {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Title,
    
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ChocoInstall,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Description
    )
   
 do
 {
    Clear-Host
    Write-Host "Descripcion: $Description"
    Write-Host "================ $Title ================"
    Write-Host "Y: Presionar 's' para instalar."
    Write-Host "2: Presionar 'n' para saltear."
    $selection = Read-Host "Elija una opcion:"
    switch ($selection)
    {
    's' { choco install $ChocoInstall -y }
    'n' { Break }
    }
 }
 until ($selection -match "s" -or $selection -match "n")
}
   