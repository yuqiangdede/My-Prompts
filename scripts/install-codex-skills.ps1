param(
    [ValidateSet("Global", "Project")]
    [string]$Scope = "Global",

    [string]$ProjectPath,

    [string[]]$Include = @(),

    [switch]$All,

    [switch]$List,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillsRoot = Join-Path $RepoRoot "skills"

if (-not (Test-Path $SkillsRoot)) {
    throw "Skills directory not found: $SkillsRoot"
}

$SkillDirs = Get-ChildItem -Path $SkillsRoot -Recurse -File -Filter "SKILL.md" |
    ForEach-Object { $_.Directory } |
    Sort-Object FullName -Unique

$SkillMap = @{}
foreach ($dir in $SkillDirs) {
    $name = $dir.Name
    if ($SkillMap.ContainsKey($name)) {
        throw "Duplicate skill directory name detected: $name`n$($SkillMap[$name])`n$($dir.FullName)"
    }
    $SkillMap[$name] = $dir.FullName
}

if ($List) {
    Write-Host "Available skills:" -ForegroundColor Cyan
    $SkillMap.Keys | Sort-Object | ForEach-Object {
        $relative = [System.IO.Path]::GetRelativePath($RepoRoot, $SkillMap[$_])
        Write-Host ("  {0,-40} {1}" -f $_, $relative)
    }
    exit 0
}

if (-not $All -and $Include.Count -eq 0) {
    Write-Host "No skills selected." -ForegroundColor Yellow
    Write-Host "Use -List to view skills, -Include <name1,name2> to install selected skills, or -All to install all skills."
    exit 1
}

if ($Scope -eq "Global") {
    $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
}
else {
    if ([string]::IsNullOrWhiteSpace($ProjectPath)) {
        throw "-ProjectPath is required when -Scope Project is used."
    }

    $ResolvedProject = (Resolve-Path $ProjectPath).Path
    $DestinationRoot = Join-Path $ResolvedProject ".agents\skills"
}

New-Item -ItemType Directory -Path $DestinationRoot -Force | Out-Null

if ($All) {
    $SelectedNames = $SkillMap.Keys | Sort-Object
}
else {
    $SelectedNames = $Include | ForEach-Object { $_.Trim() } | Where-Object { $_ } | Sort-Object -Unique
}

$Installed = @()
$Skipped = @()

foreach ($name in $SelectedNames) {
    if (-not $SkillMap.ContainsKey($name)) {
        Write-Warning "Unknown skill: $name"
        $Skipped += $name
        continue
    }

    $source = $SkillMap[$name]
    $destination = Join-Path $DestinationRoot $name

    if (Test-Path $destination) {
        if (-not $Force) {
            Write-Warning "Already exists, skipped: $destination (use -Force to replace)"
            $Skipped += $name
            continue
        }

        Remove-Item -Path $destination -Recurse -Force
    }

    Copy-Item -Path $source -Destination $destination -Recurse -Force
    $Installed += $name
    Write-Host "Installed: $name -> $destination" -ForegroundColor Green
}

Write-Host ""
Write-Host "Destination: $DestinationRoot" -ForegroundColor Cyan
Write-Host "Installed: $($Installed.Count)"
Write-Host "Skipped:   $($Skipped.Count)"

if ($Installed.Count -gt 0) {
    Write-Host ""
    Write-Host "Codex normally detects skill changes automatically. If the new skills do not appear, restart Codex." -ForegroundColor Yellow
}
