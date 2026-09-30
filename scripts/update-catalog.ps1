param([string]$Root)

$ErrorActionPreference = 'Stop'
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
$Root = (Resolve-Path -LiteralPath $Root).Path
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Get-Title($Content, $Fallback) {
    $match = [regex]::Match($Content, '(?m)^#\s+(.+?)\s*$')
    if ($match.Success) { return $match.Groups[1].Value.Trim().Replace('`', '') }
    return $Fallback
}

function Get-Link($Path) {
    return (($Path -split '/' | ForEach-Object { [uri]::EscapeDataString($_) }) -join '/')
}

$entries = @()
foreach ($kind in @('Prompt', 'Skill', 'Agent', '历史稿')) {
    $folder = switch ($kind) {
        'Prompt' { '提示词/prompts' }
        'Skill' { '技能/skills' }
        'Agent' { '智能体/agents' }
        '历史稿' { '技能/skills/需求 设计 实现' }
    }
    $files = Get-ChildItem -LiteralPath (Join-Path $Root $folder) -Recurse -File |
        Where-Object {
            $candidate = $_
            switch ($kind) {
                'Prompt' { $candidate.Extension -eq '.md' -and $candidate.Name -ne 'README.md' }
                'Skill' { $candidate.Name -eq 'SKILL.md' }
                'Agent' { $candidate.Name -eq 'AGENT.md' }
                '历史稿' { $candidate.Extension -eq '.md' -and $candidate.Name -ne 'README.md' }
            }
        }
    foreach ($file in $files) {
        $path = $file.FullName.Substring($Root.Length + 1).Replace('\', '/')
        $content = [IO.File]::ReadAllText($file.FullName)
        $category = ($path -split '/')[2]
        $type = $kind
        if ($kind -eq 'Prompt' -and $path -match '/examples/') { $type = '示例' }
        $description = ''
        $match = [regex]::Match($content, '(?m)^description:\s*(.+)$')
        if ($match.Success) { $description = $match.Groups[1].Value.Trim() }
        if (-not $description) {
            $description = ($content -split '\r?\n' | Where-Object {
                $_.Trim() -and $_ -notmatch '^\s*(#|---|```|\||\[|name:|description:)'
            } | Select-Object -First 1)
        }
        $entries += [pscustomobject]@{
            type = $type; category = $category
            title = Get-Title $content $file.BaseName
            description = [string]$description
            path = $path; link = Get-Link $path
        }
    }
}
$entries = @($entries | Sort-Object type, category, path)
$lines = @('# 内容总目录', '', '按类型和分类列出具体入口。浏览器搜索与筛选请打开 [本地导航页](catalog.html)。', '',
    '此文件由 `scripts/update-catalog.ps1` 自动生成；修改源文件后运行脚本刷新。', '',
    '[返回首页](README.md)', '')
foreach ($type in @('Prompt', 'Skill', 'Agent', '示例', '历史稿')) {
    $items = @($entries | Where-Object { $_.type -eq $type })
    $lines += @("<a id=`"$($type.ToLowerInvariant())`"></a>", '', "## $type（$($items.Count)）", '')
    foreach ($category in @($items.category | Select-Object -Unique)) {
        $lines += @("### $category", '', '| 名称 | 用途 |', '| --- | --- |')
        foreach ($item in @($items | Where-Object { $_.category -eq $category })) {
            $title = $item.title.Replace('|', '\|')
            $description = $item.description.Replace('|', '\|').Replace('`', '')
            $lines += "| [$title]($($item.link)) | $description |"
        }
        $lines += ''
    }
}
[IO.File]::WriteAllText((Join-Path $Root 'CATALOG.md'), ($lines -join "`n").TrimEnd() + "`n", $utf8)
$json = ConvertTo-Json -InputObject $entries -Depth 4 -Compress
$json = $json.Replace('<', '\u003c')
$html = @'
<!doctype html>
<html lang="zh-CN">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>My-Prompts 内容导航</title>
<style>
body{margin:0;background:#f6f7f9;color:#202b3b;font:16px/1.65 system-ui,sans-serif}main{max-width:1100px;margin:40px auto;padding:0 24px}h1{margin-bottom:8px}p{color:#586477}a{color:#255bc4}nav{display:flex;gap:12px;flex-wrap:wrap;margin:24px 0}input,select{font:inherit;padding:10px;border:1px solid #cbd2dc;border-radius:8px;background:white}input{flex:1;min-width:220px}article{background:white;border:1px solid #e0e4ea;border-radius:12px;padding:18px;margin:12px 0}h2{font-size:18px;margin:0}article p{margin:8px 0}.meta{font-size:13px;color:#697689}.path{overflow-wrap:anywhere;font-size:12px}label{display:flex;flex-direction:column;font-size:13px}#count{display:block}a:focus-visible,input:focus-visible,select:focus-visible{outline:3px solid #8db5ff;outline-offset:3px}
</style>
<main>
<h1>My-Prompts 内容导航</h1>
<p>Prompt：复制后使用 · Skill：执行可复用流程 · Agent：编排能力。示例和历史稿单独筛选。</p>
<a href="README.md">仓库首页</a> · <a href="CATALOG.md">Markdown 总目录</a>
<nav aria-label="筛选内容">
<label style="flex:1">搜索<input id="q" type="search" placeholder="搜索名称、用途、关键词或路径"></label>
<label>类型<select id="type"><option value="">当前内容</option><option>Prompt</option><option>Skill</option><option>Agent</option><option>示例</option><option>历史稿</option><option value="all">全部内容</option></select></label>
<label>分类<select id="category"><option value="">全部分类</option></select></label>
</nav>
<output id="count" aria-live="polite"></output><section id="results" aria-label="内容列表"></section>
</main>
<script id="data" type="application/json">__DATA__</script>
<script>
const data=JSON.parse(document.getElementById('data').textContent);
const q=document.getElementById('q'),type=document.getElementById('type'),category=document.getElementById('category'),results=document.getElementById('results');
for(const value of [...new Set(data.map(x=>x.category))].sort()){const option=document.createElement('option');option.textContent=value;category.append(option)}
function render(){
 const words=q.value.trim().toLocaleLowerCase().split(/\s+/).filter(Boolean);
 const items=data.filter(x=>(type.value==='all'||(type.value?x.type===type.value:!['历史稿','示例'].includes(x.type)))&&(!category.value||x.category===category.value)&&words.every(w=>[x.title,x.description,x.path,x.category,x.type].join(' ').toLocaleLowerCase().includes(w)));
 results.replaceChildren();document.getElementById('count').textContent=`找到 ${items.length} 项，共 ${data.length} 项`;
 for(const x of items){const card=document.createElement('article');const meta=document.createElement('div');meta.className='meta';meta.textContent=`${x.type} · ${x.category}`;const h=document.createElement('h2');const a=document.createElement('a');a.href=x.link;a.textContent=x.title;h.append(a);const p=document.createElement('p');p.textContent=x.description;const path=document.createElement('div');path.className='meta path';path.textContent=x.path;card.append(meta,h,p,path);results.append(card)}
 if(!items.length){const p=document.createElement('p');p.textContent='没有匹配内容，请调整关键词或筛选条件。';results.append(p)}
}
for(const input of [q,type,category])input.addEventListener('input',render);render();
</script>
</html>
'@
[IO.File]::WriteAllText((Join-Path $Root 'catalog.html'), $html.Replace('__DATA__', $json), $utf8)
foreach ($entry in $entries) {
    if (-not (Test-Path -LiteralPath (Join-Path $Root $entry.path) -PathType Leaf)) { throw "Missing target: $($entry.path)" }
}
Write-Output "Catalog updated: $($entries.Count) entries; all targets exist."
