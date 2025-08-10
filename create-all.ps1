param (
    [switch]$Force,
    [switch]$Quiet
)

$basePath = "scripts"
$log = @()
$createdFolders = 0
$createdScripts = 0
$createdReadmes = 0

$structure = @{
    "auth"  = @("create-login.ps1", "create-register.ps1", "create-protected-route.ps1");
    "media" = @("create-media-uploader.ps1", "create-media-grid.ps1");
    "admin" = @("create-admin-table.ps1");
    "user"  = @("create-espace-membre.ps1", "create-profil.ps1");
    "core"  = @("create-navbar.ps1", "create-app.ps1", "create-auth-context.ps1");
}

# Créer le dossier racine s’il n’existe pas
if (-not (Test-Path $basePath)) {
    New-Item -ItemType Directory -Path $basePath | Out-Null
    $log += "📁 Dossier racine créé: $basePath"
} else {
    $log += "📁 Dossier racine déjà existant: $basePath"
}

# Générer les dossiers, scripts et README locaux
foreach ($category in $structure.Keys) {
    $categoryPath = Join-Path $basePath $category

    if (-not (Test-Path $categoryPath)) {
        New-Item -ItemType Directory -Path $categoryPath | Out-Null
        $log += "📁 Dossier créé: $categoryPath"
        $createdFolders++
    } else {
        $log += "📁 Dossier déjà existant: $categoryPath"
    }

    foreach ($scriptName in $structure[$category]) {
        $scriptPath = Join-Path $categoryPath $scriptName
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $header = "# $scriptName`n# Script pour la catégorie '$category'`n# Généré le $timestamp`n"

        if ($Force -or -not (Test-Path $scriptPath)) {
            Set-Content -Path $scriptPath -Value $header -Encoding UTF8
            $log += "📝 Script généré: $scriptPath"
            $createdScripts++
        } else {
            $log += "📝 Script conservé: $scriptPath"
        }
    }

    $readmePath = Join-Path $categoryPath "README.md"
    if ($Force -or -not (Test-Path $readmePath)) {
        $readmeLines = @()
        $readmeLines += "# Dossier : $category"
        $readmeLines += ""
        $readmeLines += "Ce dossier contient les scripts PowerShell liés à la catégorie **$category**."
        $readmeLines += ""
        $readmeLines += "## Scripts inclus"

        foreach ($scriptName in $structure[$category]) {
            $readmeLines += "- `$scriptName`"
        }

        $readmeLines += ""
        $readmeLines += "Les scripts sont générés automatiquement pour Castalia."

        Set-Content -Path $readmePath -Value $readmeLines -Encoding UTF8
        $log += "📄 README.md généré: $readmePath"
        $createdReadmes++
    } else {
        $log += "📄 README.md conservé: $readmePath"
    }
}

# Générer le README global à la racine du projet
$globalReadmePath = "README.md"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$globalLines = @()
$globalLines += "# Castalia – Structure des scripts PowerShell"
$globalLines += ""
$globalLines += "📅 Généré automatiquement le `$timestamp`"
$globalLines += ""
$globalLines += "## À propos du projet"
$globalLines += "Castalia est une plateforme collaborative dont les scripts PowerShell facilitent la mise en place de composants modulaires, sécurisés et documentés."
$globalLines += ""
$globalLines += "Ce fichier récapitule l’ensemble des scripts organisés par catégorie, avec des liens vers leur documentation locale."
$globalLines += ""
$globalLines += "## Catégories disponibles"

foreach ($category in $structure.Keys) {
    $readmeRelPath = "scripts/$category/README.md"
    $globalLines += ""
    $globalLines += "### $category"
    $globalLines += "[Voir README]($readmeRelPath)"
    $globalLines += ""

    foreach ($scriptName in $structure[$category]) {
        $globalLines += "- `$scriptName`"
    }
}

$globalLines += ""
$globalLines += "_Ce fichier est généré automatiquement par `create-all.ps1`. Ne pas modifier manuellement._"

Set-Content -Path $globalReadmePath -Value $globalLines -Encoding UTF8
$log += "📘 README.md global enrichi généré à la racine: $globalReadmePath"

# Affichage du journal
if (-not $Quiet) {
    Write-Host "`n=== Journal de création Castalia ===`n"
    $log | ForEach-Object { Write-Host $_ }

    Write-Host "`n=== Résumé ==="
    Write-Host "📁 Dossiers créés     : $createdFolders"
    Write-Host "📝 Scripts générés    : $createdScripts"
    Write-Host "📄 README.md générés  : $createdReadmes"
    Write-Host "`n✅ Structure Castalia générée avec succès."
}