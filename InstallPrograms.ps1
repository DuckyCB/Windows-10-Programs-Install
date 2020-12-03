
$tweaks = @(
	"RequireAdmin",
	"InstallChocolatey",
	"InstallEssentials",
	"InstallDeveloppment",
	"InstallEditing",
	"InstallComunication",
	"InstallSecurity",
	"InstallMusic",
	"InstallGaming",
	"InstallBackup"
)

# Instala un package manager
Function InstallChocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Instala programas basicos
Function InstallEssentials {
	Show-Choco-Menu -Title "Instalar Firefox?" -ChocoInstall "firefox" -Description "Navegador web Open source"
	Show-Choco-Menu -Title "Instalar Brave?" -ChocoInstall "brave" -Description "Navegador web basado en Chromium"
	choco install 7zip.install -y
}

# Programacion
Function InstallDeveloppment {
	choco install git -y
	choco install python3 -y
	choco install nodejs.install -y
	choco install vscode -y
	choco install microsoft-windows-terminal -y
	Show-Choco-Menu -Title "Instalar IntelliJ Idea Ultimate?" -ChocoInstall "intellijidea-ultimate" -Description "La mejor IDE para Java"
	Show-Choco-Menu -Title "Instalar PyCharm?" -ChocoInstall "pycharm" -Description "La mejor IDE para Python"
	Show-Choco-Menu -Title "Instalar PHPStorm?" -ChocoInstall "phpstorm" -Description "La mejor IDE para desarollo web"
	do {
		Clear-Host
		Write-Host "================ Instalar MySQL + DBeaver + Postman? ================"
		Write-Host "S: Presionar 's' para instalar."
		Write-Host "N: Presionar 'n' para saltear."
		$selection = Read-Host "Elija una opcion:"
		switch ($selection) {
			's' {
				choco install mysql -y
				choco install dbeaver -y
				choco install postman -y
			} 'n' { 
				Break 
			}
		}
	} until ($selection -match "s" -or $selection -match "n")
}

# Edicion
Function InstallEditing {
	Show-Choco-Menu -Title "Instalar Gimp?" -ChocoInstall "gimp" -Description "Edicion a nivel de pixeles en fotografias"
	Show-Choco-Menu -Title "Instalar Audacity?" -ChocoInstall "audacity" -Description "Edicion de audio"
	Show-Choco-Menu -Title "Instalar Blender?" -ChocoInstall "blender" -Description "Edicion 3D de objetos"
	Show-Choco-Menu -Title "Instalar Inkscape?" -ChocoInstall "inkscape" -Description "Edicion vectorial de imagenes"
}

# Comunicacion
Function InstallComunication {
	choco install discord -y
	choco install whatsapp -y
	choco install microsoft-teams -y
	Show-Choco-Menu -Title "Instalar Telegram?" -ChocoInstall "telegram" -Description "Plataforma de mensajes mejor que whatsapp"
	Show-Choco-Menu -Title "Instalar Slack?" -ChocoInstall "slack" -Description "Plataforma de mensajes que usa Dani"
}

# Seguridad
Function InstallSecurity {
	choco install keepassxc -y
	choco install authy-desktop -y
}

# Musica
Function InstallMusic {
	choco install spotify -y
	Show-Choco-Menu -Title "Instalar MusicBee?" -ChocoInstall "musicbee" -Description "Reproductor de musica, uno de los mejores"
}

# Juegos
Function InstallGaming {
	choco install steam -y
	choco install epicgameslauncher -y
}

# Backup
Function InstallBackup {
	choco install google-backup-and-sync -y
}

Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
}

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

	do {
		Clear-Host
		Write-Host "Descripcion: $Description"
		Write-Host "================ $Title ================"
		Write-Host "Y: Presionar 's' para instalar."
		Write-Host "2: Presionar 'n' para saltear."
		$selection = Read-Host "Elija una opcion:"
		switch ($selection) {
			's' {
				choco install $ChocoInstall -y 
			} 'n' {
				Break 
			}
		}
	} until ($selection -match "s" -or $selection -match "n")

}

# Normalize path to preset file
$preset = ""
$PSCommandArgs = $args
If ($args -And $args[0].ToLower() -eq "-preset") {
	$preset = Resolve-Path $($args | Select-Object -Skip 1)
	$PSCommandArgs = "-preset `"$preset`""
}

# Load function names from command line arguments or a preset file
If ($args) {
	$tweaks = $args
	If ($preset) {
		$tweaks = Get-Content $preset -ErrorAction Stop | ForEach { $_.Trim() } | Where { $_ -ne "" -and $_[0] -ne "#" }
	}
}

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }
   