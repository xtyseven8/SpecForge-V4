# report-path.ps1
# SpecForge V4 - 生成 report 文件路径（并初始化空模板）
# 用法: .\report-path.ps1 -FeatureName "搜索功能" -TaskNumber 1
# 生成: .specforge/reports/task-1-report.md（空模板）

param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName,

    [Parameter(Mandatory=$true)]
    [int]$TaskNumber,

    [string]$ProjectRoot = "."
)

$ErrorActionPreference = "Stop"

$reportDir = Join-Path $ProjectRoot ".specforge/reports"
$reportPath = Join-Path $reportDir "task-$TaskNumber-report.md"

if (-not (Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
}

if (-not (Test-Path $reportPath)) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $template = @"
# Task-$TaskNumber 实现报告

## 功能: $FeatureName
## 创建时间: $timestamp
## 状态: 待执行

---

## RED 阶段
（待填写：写了什么测试、测试了什么行为、失败结果）

## GREEN 阶段
（待填写：实现的核心逻辑、测试通过结果）

## REFACTOR 阶段
（待填写：重构了什么、测试是否始终通过）

## 验收测试
（待填写：验收方式、验收结果）

## 阻塞与偏差
（如有：遇到的阻塞、与技术方案的偏差）

## 结论
（待填写：任务完成 / 需要修复 / 需要用户决策）
"@
    Set-Content -Path $reportPath -Value $template -Encoding UTF8
}

Write-Output $reportPath
