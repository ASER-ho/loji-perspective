# Loji Perspective Skill - One-click install (Windows PowerShell)
# https://github.com/ASER-ho/loji-perspective

$ErrorActionPreference = "Stop"

$SkillDir = if ($env:CLAUDE_SKILLS_DIR) {
    Join-Path $env:CLAUDE_SKILLS_DIR "loji-perspective"
} else {
    Join-Path $env:USERPROFILE ".claude\skills\loji-perspective"
}
$RepoUrl = "https://github.com/ASER-ho/loji-perspective.git"

Write-Host "=== Loji Perspective Skill Installer ===" -ForegroundColor Cyan
Write-Host ""

# Clone or update
if (Test-Path "$SkillDir\.git") {
    Write-Host "[1/3] Updating existing installation..." -ForegroundColor Yellow
    Set-Location $SkillDir
    git pull origin master
} else {
    Write-Host "[1/3] Cloning to $SkillDir ..." -ForegroundColor Yellow
    git clone $RepoUrl $SkillDir
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

# Verify
Write-Host "[3/3] Verifying installation..." -ForegroundColor Yellow
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
} else {
    Write-Host "ERROR: SKILL.md not found. Installation may have failed." -ForegroundColor Red
    exit 1
}
