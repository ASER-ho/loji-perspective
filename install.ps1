# Loji Perspective Skill - Installer (Windows PowerShell)
# https://github.com/ASER-ho/loji-perspective
#
# Pinned to v0.3.1. DO NOT pipe from irm to iex on mutable master.
# Download this script, review it, then run it.

$ErrorActionPreference = "Stop"

$SkillDir = if ($env:CLAUDE_SKILLS_DIR) {
    Join-Path $env:CLAUDE_SKILLS_DIR "loji-perspective"
} else {
    Join-Path $env:USERPROFILE ".claude\skills\loji-perspective"
}
$RepoUrl = "https://github.com/ASER-ho/loji-perspective.git"
$PinnedTag = "v0.3.1"

Write-Host "=== Loji Perspective Skill Installer ===" -ForegroundColor Cyan
Write-Host "Version: $PinnedTag"
Write-Host "Target:  $SkillDir"
Write-Host ""

# Clone or update
if (Test-Path "$SkillDir\.git") {
    Write-Host "[1/3] Updating existing installation to $PinnedTag..." -ForegroundColor Yellow
    Set-Location $SkillDir
    git fetch origin tag $PinnedTag 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Cannot fetch tag $PinnedTag. Check network and try again." -ForegroundColor Red
        exit 1
    }
    git checkout --detach $PinnedTag 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Tag $PinnedTag not found on remote." -ForegroundColor Red
        Write-Host "This installer is pinned to a specific version for safety."
        Write-Host "To install the latest development version, use manual install:"
        Write-Host "  git clone $RepoUrl $SkillDir"
        exit 1
    }
} else {
    Write-Host "[1/3] Cloning $PinnedTag to $SkillDir ..." -ForegroundColor Yellow
    git clone --branch $PinnedTag --depth 1 $RepoUrl $SkillDir 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Cannot clone tag $PinnedTag." -ForegroundColor Red
        Write-Host "The tag may not exist yet on GitHub. Check:"
        Write-Host "  git ls-remote --tags $RepoUrl"
        exit 1
    }
    Set-Location $SkillDir
}

# Initialize memory file
Write-Host "[2/3] Setting up local memory..." -ForegroundColor Yellow
if (-not (Test-Path "$SkillDir\memory.md")) {
    Copy-Item "$SkillDir\memory.template.md" "$SkillDir\memory.md"
    Write-Host "       memory.md created from template." -ForegroundColor Green
} else {
    Write-Host "       memory.md already exists - skipping." -ForegroundColor Green
}

# Installation summary (not verification)
Write-Host "[3/3] Installation summary..." -ForegroundColor Yellow
if (Test-Path "$SkillDir\SKILL.md") {
    $skillLines = (Get-Content "$SkillDir\SKILL.md" | Measure-Object -Line).Lines
    $refCount = (Get-ChildItem "$SkillDir\references" -File -ErrorAction SilentlyContinue | Measure-Object).Count
    $evalCount = (Get-ChildItem "$SkillDir\evals" -File -ErrorAction SilentlyContinue | Measure-Object).Count
    $exampleCount = (Get-ChildItem "$SkillDir\examples" -File -ErrorAction SilentlyContinue | Measure-Object).Count
    $hasMemory = Test-Path "$SkillDir\memory.md"

    Write-Host "       SKILL.md : $skillLines lines" -ForegroundColor Green
    Write-Host "       memory.md: $(if ($hasMemory) { 'present' } else { 'missing' })" -ForegroundColor Green
    Write-Host "       references/: $refCount files" -ForegroundColor Green
    Write-Host "       evals/     : $evalCount files" -ForegroundColor Green
    Write-Host "       examples/  : $exampleCount files" -ForegroundColor Green
    Write-Host ""
    Write-Host "=== Installation complete ===" -ForegroundColor Cyan
    Write-Host "Try: '征酱，你好' in a new conversation"
    Write-Host ""
    Write-Host "Note: This is an installation summary, not a security verification."
    Write-Host "For full validation, run the eval suite: see evals/RUBRIC.md"
} else {
    Write-Host "ERROR: SKILL.md not found. Installation may have failed." -ForegroundColor Red
    exit 1
}
