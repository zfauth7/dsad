# Definir o caminho da chave do registro
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

# Caminhos dos executáveis
$appPathMTA = "C:\Program Files (x86)\MTA San Andreas 1.6\Multi Theft Auto.exe"
$appPathGTA = "C:\ProgramData\MTA San Andreas All\1.6\GTA San Andreas\gta_sa.exe"

# Valor que habilita a otimização de tela inteira
$valueToAdd = "~ DISABLEDXMAXIMIZEDWINDOWEDMODE"

# Função para adicionar ou atualizar a entrada do registro
function Add-OrUpdateRegistryEntry {
    param (
        [string]$path,
        [string]$appPath,
        [string]$value
    )

    if (-not (Get-ItemProperty -Path $path -Name $appPath -ErrorAction SilentlyContinue)) {
        New-ItemProperty -Path $path -Name $appPath -Value $value -PropertyType String
        Write-Host "A entrada para $appPath foi criada no Registro."
    } else {
        Set-ItemProperty -Path $path -Name $appPath -Value $value
        Write-Host "A entrada para $appPath já existia no Registro e foi atualizada."
    }
}

# Habilitar a otimização de tela inteira para MTA e GTA
Add-OrUpdateRegistryEntry -path $registryPath -appPath $appPathMTA -value $valueToAdd
Add-OrUpdateRegistryEntry -path $registryPath -appPath $appPathGTA -value $valueToAdd

# Verificações finais
$currentValueMTA = (Get-ItemProperty -Path $registryPath -Name $appPathMTA).$appPathMTA
$currentValueGTA = (Get-ItemProperty -Path $registryPath -Name $appPathGTA).$appPathGTA

Write-Host "Valor atual para MTA: $currentValueMTA"
Write-Host "Valor atual para GTA: $currentValueGTA"