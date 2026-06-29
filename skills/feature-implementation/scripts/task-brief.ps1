# task-brief.ps1
# SpecForge V4 - 提取任务全文到 task-brief 文件
# 用法: .\task-brief.ps1 -FeatureName "搜索功能" -TaskNumber 1 -TaskContent "任务全文..."
# 生成: .specforge/briefs/task-1-brief.md

param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName,

    [Parameter(Mandatory=$true)]
    [int]$TaskNumber,

    [Parameter(Mandatory=$true)]
    [string]$TaskContent,

    [string]$ProjectRoot = "."
)

$ErrorActionPreference = "Stop"

$briefDir = Join-Path $ProjectRoot ".specforge/briefs"
$briefPath = Join-Path $briefDir "task-$TaskNumber-brief.md"

if (-not (Test-Path $briefDir)) {
    New-Item -ItemType Directory -Path $briefDir -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$content = @"
# Task-$TaskNumber Brief

## 功能: $FeatureName
## 生成时间: $timestamp

---

## 任务全文

$TaskContent

---

## 执行指引

1. 严格按照本 brief 中的任务描述和验证标准执行 TDD 循环
2. 遵循 RED -> GREEN -> REFACTOR 顺序
3. 完成后将执行过程写入对应的 report 文件
4. 不做计划外的任务，不修改技术方案
5. 遇到阻塞在 report 中记录，不要自行决策
"@"

Set-Content -Path $briefPath -Value $content -Encoding UTF8
Write-Output $briefPath
