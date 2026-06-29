# review-package.ps1
# SpecForge V4 - 生成 git diff 包到 review 文件
# 用法: .\review-package.ps1 -FeatureName "搜索功能" -TaskNumber 1 -BaseCommit "a1b2c3" -HeadCommit "d4e5f6"
# 生成: .specforge/reviews/task-1-diff.md

param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName,

    [Parameter(Mandatory=$true)]
    [int]$TaskNumber,

    [Parameter(Mandatory=$true)]
    [string]$BaseCommit,

    [Parameter(Mandatory=$true)]
    [string]$HeadCommit,

    [string]$ProjectRoot = "."
)

$ErrorActionPreference = "Stop"

$reviewDir = Join-Path $ProjectRoot ".specforge/reviews"
$reviewPath = Join-Path $reviewDir "task-$TaskNumber-diff.md"

if (-not (Test-Path $reviewDir)) {
    New-Item -ItemType Directory -Path $reviewDir -Force | Out-Null
}

Set-Location $ProjectRoot
$diffOutput = git diff "$BaseCommit..$HeadCommit" 2>&1

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$content = @"
# Task-$TaskNumber Review Package

## 功能: $FeatureName
## 生成时间: $timestamp
## Commit 范围: $BaseCommit..$HeadCommit

---

## Git Diff

``````diff
$diffOutput
``````

---

## 审查指引

1. 检查 diff 是否符合 task-brief 中的任务描述
2. 检查代码质量（DRY、YAGNI、命名、错误处理）
3. 检查与项目现有代码风格的一致性
4. 检查测试质量（是否真正验证行为，而非凑覆盖率）
5. 严重程度分级：Critical（阻塞）/ Important（建议修复）/ Minor（可选）
"@"

Set-Content -Path $reviewPath -Value $content -Encoding UTF8
Write-Output $reviewPath
