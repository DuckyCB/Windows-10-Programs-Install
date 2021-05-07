
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


Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
}

# Instala un package manager
Function InstallChocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Instala programas basicos
Function InstallEssentials {
	choco install firefox -y
	choco install brave -y
	choco install 7zip.install -y
	choco install notion -y
	choco install powertoys -y
}

# Programacion
Function InstallDeveloppment {
	choco install git -y
	choco install python3 -y
	choco install nodejs.install -y
	choco install vscode -y
	choco install microsoft-windows-terminal -y
	choco install intellijidea-ultimate -y
	choco install pycharm -y
	choco install phpstorm -y
	choco install androidstudio -y
	choco install winscp -y
	# choco install mysql -y
	# choco install dbeaver -y
	# choco install postman -y
}

# Edicion
Function InstallEditing {
	choco install gimp -y
	choco install audacity -y
	choco install blender -y
	choco install inkscape -y
}

# Comunicacion
Function InstallComunication {
	choco install discord -y
	choco install telegram -y
	choco install whatsapp -y
	choco install microsoft-teams -y
	choco install slack -y
}

# Seguridad
Function InstallSecurity {
	choco install keepassxc -y
	choco install authy-desktop -y

}

# Musica
Function InstallMusic {
	choco install spotify -y
	choco install musicbee -y
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
   