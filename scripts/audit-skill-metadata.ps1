param(
    [string]$Root
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = Split-Path -Parent $PSScriptRoot
}

$SkillsRoot = Join-Path $Root "技能\skills"
if (-not (Test-Path $SkillsRoot)) {
    throw "Skills directory not found: $SkillsRoot"
}

$Errors = New-Object System.Collections.Generic.List[string]
$Warnings = New-Object System.Collections.Generic.List[string]
$Names = @{}
$Files = Get-ChildItem -Path $SkillsRoot -Recurse -File -Filter "SKILL.md"

foreach ($file in $Files) {
    $lines = Get-Content -Path $file.FullName -Encoding UTF8
    $relative = $file.FullName.Substring($Root.TrimEnd('\','/').Length).TrimStart('\','/')

    if ($lines.Count -lt 4 -or $lines[0].Trim() -ne '---') {
        $Errors.Add("$relative : missing YAML frontmatter")
        continue
    }

    $end = -1
    for ($i = 1; $i -lt [Math]::Min($lines.Count, 30); $i++) {
        if ($lines[$i].Trim() -eq '---') {
            $end = $i
            break
        }
    }

    if ($end -lt 0) {
        $Errors.Add("$relative : YAML frontmatter is not closed within first 30 lines")
        continue
    }

    $nameLine = $lines[1..($end - 1)] | Where-Object { $_ -match '^name\s*:' } | Select-Object -First 1
    $descriptionLine = $lines[1..($end - 1)] | Where-Object { $_ -match '^description\s*:' } | Select-Object -First 1

    if (-not $nameLine) {
        $Errors.Add("$relative : missing name")
        continue
    }

    $name = ($nameLine -replace '^name\s*:\s*', '').Trim().Trim('"','''')
    $directoryName = $file.Directory.Name

    if ($name -ne $directoryName) {
        $Errors.Add("$relative : name '$name' does not match directory '$directoryName'")
    }

    if ($name -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
        $Errors.Add("$relative : name '$name' is not kebab-case")
    }

    if ($Names.ContainsKey($name)) {
        $Errors.Add("$relative : duplicate skill name '$name' also used by $($Names[$name])")
    }
    else {
        $Names[$name] = $relative
    }

    if (-not $descriptionLine) {
        $Errors.Add("$relative : missing description")
        continue
    }

    $description = ($descriptionLine -replace '^description\s*:\s*', '').Trim().Trim('"','''')
    if ([string]::IsNullOrWhiteSpace($description)) {
        $Errors.Add("$relative : empty description")
    }
    elseif ($description.Length -lt 30) {
        $Warnings.Add("$relative : description may be too short ($($description.Length) chars)")
    }

    if ($description -notmatch '不用于|不负责|应使用|直接使用|不应触发|不直接|不做|不开发|不把|禁止|不属于') {
        $Warnings.Add("$relative : description has no explicit negative/adjacent-skill boundary")
    }
}

Write-Host "Skill metadata audit" -ForegroundColor Cyan
Write-Host "Root:   $Root"
Write-Host "Skills: $($Files.Count)"
Write-Host "Errors: $($Errors.Count)"
Write-Host "Warnings: $($Warnings.Count)"

if ($Warnings.Count -gt 0) {
    Write-Host ""
    Write-Host "Warnings:" -ForegroundColor Yellow
    $Warnings | ForEach-Object { Write-Host "- $_" }
}

if ($Errors.Count -gt 0) {
    Write-Host ""
    Write-Host "Errors:" -ForegroundColor Red
    $Errors | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host ""
Write-Host "PASS: all SKILL.md files have valid discoverable metadata." -ForegroundColor Green
exit 0
