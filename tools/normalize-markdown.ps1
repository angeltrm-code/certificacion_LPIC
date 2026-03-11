param(
    [string]$Preview,
    [switch]$Apply
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$BulletChar = [string][char]0x2022
$MidDotChar = [string][char]0x00B7
$TreeChars = @([char]0x251C, [char]0x2514, [char]0x2502)
$Aacute = [char]0x00E1
$Eacute = [char]0x00E9
$Iacute = [char]0x00ED
$Oacute = [char]0x00F3
$Uacute = [char]0x00FA
$PagePattern = '(?i)\bmanual\b|\bp(?:a|' + $Aacute + ')gina\b|pdf'

function Read-Text([string]$Path) {
    return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Write-Text([string]$Path, [string]$Content) {
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8NoBom)
}

function Get-DocType([string]$Name) {
    if ($Name -match '(?i)^(laboratorio|lab)') { return 'lab' }
    if ($Name -match '(?i)^ejercicio') { return 'exercise' }
    if ($Name -match '(?i)^explicacion') { return 'explanation' }
    if ($Name -match '(?i)^resumen') { return 'summary' }
    if ($Name -match '(?i)^clase') { return 'class' }
    return 'reference'
}

function Clean-Title([string]$Value) {
    $title = [IO.Path]::GetFileNameWithoutExtension($Value)
    $title = $title -replace '[_]+', ' '
    $title = $title -replace '\s*-\s*', ' '
    $title = $title -replace '(?<=[A-Za-z])(?=\d)', ' '
    $title = $title -replace '(?<=\d)(?=[A-Za-z])', ' '
    $title = $title -replace '^(?:\d+\s*)+', ''
    $title = $title -replace '\s+', ' '
    $title = $title.Trim(' ', '-', '.')
    if (-not $title) { $title = 'Documento' }

    $replacements = [ordered]@{
        '\bLPIC\b'         = 'LPIC'
        '\bNTP\b'          = 'NTP'
        '\bSSHD\b'         = 'SSHD'
        '\bSSH\b'          = 'SSH'
        '\bOpenSSH\b'      = 'OpenSSH'
        '\bRPM\b'          = 'RPM'
        '\bDPKG\b'         = 'DPKG'
        '\bAPT\b'          = 'APT'
        '\bYUM\b'          = 'YUM'
        '\bDNF\b'          = 'DNF'
        '\bGPT\b'          = 'GPT'
        '\bMBR\b'          = 'MBR'
        '\bUUID\b'         = 'UUID'
        '\bXFS\b'          = 'XFS'
        '\bGNU\b'          = 'GNU'
        '\bUNIX\b'         = 'UNIX'
        '\bKVM\b'          = 'KVM'
        '\bLVM\b'          = 'LVM'
        '\bTCP\b'          = 'TCP'
        '\bUDP\b'          = 'UDP'
        '\bVM\b'           = 'VM'
        '\brsyslog\b'      = 'rsyslog'
        '\bsystemd\b'      = 'systemd'
        '\bnmcli\b'        = 'nmcli'
        '\bchrony\b'       = 'Chrony'
        '\bchronyd\b'      = 'chronyd'
        '\bchronyc\b'      = 'chronyc'
        '\bcron\b'         = 'cron'
        '\bcrond\b'        = 'crond'
        '\btimedatectl\b'  = 'timedatectl'
        '\blocalectl\b'    = 'localectl'
        '\bwhatprovides\b' = 'whatprovides'
        '\bvi\b'           = 'vi'
    }

    foreach ($entry in $replacements.GetEnumerator()) {
        $title = [regex]::Replace($title, "(?i)$($entry.Key)", $entry.Value)
    }

    return $title
}

function Get-Intro([string]$Type, [string]$Title) {
    switch ($Type) {
        'lab' {
            return "Documento pr${Aacute}ctico sobre $Title. Conserva los comandos, comprobaciones y notas t${Eacute}cnicas del material original con una estructura m${Aacute}s clara."
        }
        'exercise' {
            return "Conjunto de ejercicios sobre $Title, reorganizado para facilitar la pr${Aacute}ctica y la revisi${Oacute}n."
        }
        'explanation' {
            return "Resumen t${Eacute}cnico sobre $Title, reordenado para mejorar la lectura sin alterar el contenido ${Uacute}til."
        }
        'summary' {
            return "Resumen de estudio sobre $Title con jerarqu${Iacute}a Markdown consistente y bloques t${Eacute}cnicos normalizados."
        }
        'class' {
            return "Apuntes de clase sobre $Title, reorganizados para facilitar la consulta r${Aacute}pida y el repaso."
        }
        default {
            return "Documento de referencia sobre $Title con formato Markdown homog${Eacute}neo y navegaci${Oacute}n m${Aacute}s clara."
        }
    }
}

function Is-Separator([string]$Line) {
    return $Line -match '^\s*[-*_]{5,}\s*$'
}

function Is-CommandStart([string]$Line) {
    $trim = $Line.Trim()
    if (-not $trim) { return $false }

    if ($trim -match '^(?:[A-Za-z0-9._-]+)\s+(sirve|es|se|permite|muestra|indica|utiliza|genera|define|controla|almacena|gestiona|corresponde|incluye)\b') {
        return $false
    }

    if ($trim -match '^(sudo\s+)?(apt(-get)?|apt-cache|apt-file|dnf|yum|rpm|dpkg(-reconfigure|-deb)?|systemctl|journalctl|timedatectl|localectl|chronyd?|chronyc|crontab|tar|grep|egrep|sed|awk|sort|uniq|find|findmnt|mount|fdisk|gdisk|parted|lsblk|lsscsi|lsusb|lspci|free|arch|uname|hostname|ip|ifconfig|nmcli|netstat|ss|vi|vim|nano|cat|cp|mv|rm|mkdir|touch|stat|chmod|chown|user(add|mod|del)|group(add|mod|del)|passwd|su|ssh(d|-keygen|-agent|-add|-copy-id)?|scp|sftp|ping|traceroute|service|chkconfig|run-parts|mail|echo|tee|modprobe|lsmod|insmod|rmmod|dmesg|mkfs(\.|\b)|mkswap|swapon|swapoff|xfsdump|xfsrestore|dd|umount|route|iptables|firewall-cmd|logrotate|logger|ntpd|ntpq|ntpdate|date|hwclock|alias|export|source|bash|sh|cd|pwd|whoami|inxi|unzip|git|curl|wget|ls|du|df|install|make|gcc|ldconfig|ldd|modinfo|telnet|screen|hostnamectl|lscpu|lsb_release|tac|ifup|ifdown|nm-connection-editor)\b') {
        return $true
    }

    if ($trim -match '^(/|~/?|\./)' -and $trim -notmatch '^\S+\s{2,}\S+') {
        return $true
    }

    return $false
}

function Is-ConfigLine([string]$Line) {
    $trim = $Line.Trim()
    if (-not $trim) { return $false }

    if ($trim -match '^(Port|ListenAddress|PermitRootLogin|PasswordAuthentication|PubkeyAuthentication|AuthorizedKeysFile|UsePAM|ChallengeResponseAuthentication|X11Forwarding|AllowUsers|DenyUsers|ClientAliveInterval|ClientAliveCountMax|LANG=|LC_[A-Z_]+=|server\s+\S+\s+iburst|pool\s+\S+|service\s+\S+|flags\s*=|socket_type\s*=|wait\s*=|user\s*=|server\s*=|log_on_failure|disable\s*=|only_from|no_access|access_times|\$ModLoad|\$UDPServerRun|\$InputTCPServerRun|\*\.info;|authpriv\.\*|@include|deb\s+|defaults|UUID=|LABEL=)') {
        return $true
    }

    if ($trim -match '^[A-Za-z0-9_.-]+\s*=\s*.+$') { return $true }
    if ($trim -match '^[{}]$') { return $true }
    return $false
}

function Is-OutputLine([string]$Line) {
    $trim = $Line.Trim()
    if (-not $trim) { return $false }

    if ($trim -match '^\[.+#\s+\S+') { return $true }
    if ($trim -match '^(Disk /dev/|Disk label type:|Identificador del disco:|Units =|Sector size|I/O size|Disposit\.|NAME\s+MAJ:MIN|Local time:|Universal time:|RTC time:|Time zone:|System clock synchronized:|NTP service:|RTC in local TZ:|tcp\d?\s+\d|udp\s+\d)') { return $true }
    if ($trim -match '^[A-Za-z0-9_.-]+\s+\d+:\d+\s+\d+\s+\S+') { return $true }
    if ($trim -match '^\d{1,2}:\d{2}:\d{2}') { return $true }
    if ($trim -match '^\S+\s{2,}\S+') { return $true }

    foreach ($char in $TreeChars) {
        if ($trim.IndexOf($char) -ge 0) { return $true }
    }

    return $false
}

function Is-CronLine([string]$Line) {
    $trim = $Line.Trim()
    if (-not $trim) { return $false }
    if ($trim -match '^@(?:reboot|yearly|annually|monthly|weekly|daily|hourly)\b') { return $true }
    if ($trim -match '^[0-9*/,\-]+\s+[0-9*/,\-]+\s+[0-9*/,\-]+\s+[0-9A-Za-z*/,\-]+\s+[0-9A-Za-z*/,\-]+\s+.+') { return $true }
    return $false
}

function Is-Codeish([string]$Line) {
    return (Is-CommandStart $Line) -or (Is-ConfigLine $Line) -or (Is-OutputLine $Line) -or (Is-CronLine $Line)
}

function Normalize-Line([string]$Line) {
    $line = $Line -replace "`t", '    '
    $line = $line.TrimEnd()

    if ($line -match '^((?:#\s*){2,6})(.+?)(?:\s*#\s*)*$') {
        $count = [regex]::Matches($Matches[1], '#').Count
        $text = $Matches[2].Trim()
        if ($text) {
            return ('#' * [Math]::Min(6, $count)) + ' ' + $text
        }
    }

    if ($line -match '^(#{1,6})([^#\s].*)$') {
        return $Matches[1] + ' ' + $Matches[2].Trim()
    }

    if ($line -match '^(#{1,6})\s*(.+?)\s*#+\s*$') {
        return $Matches[1] + ' ' + $Matches[2].Trim()
    }

    if ($line -match '^\*\*(.+?)\*\*\s*$') {
        $candidate = $Matches[1].Trim()
        if ($candidate.Length -le 100) {
            return '## ' + $candidate
        }
    }

    if ($line -match '^\*([^*].+)$') {
        $candidate = $Matches[1].Trim()
        if ($candidate.Length -le 100 -and $candidate -notmatch '^[\.\-]') {
            return '## ' + $candidate
        }
    }

    $trimStart = $line.TrimStart()
    if ($trimStart.StartsWith($BulletChar) -or $trimStart.StartsWith($MidDotChar)) {
        return '- ' + $trimStart.Substring(1).Trim()
    }

    return $line
}

function Get-LineKind([string]$Line) {
    $trim = $Line.Trim()
    if (-not $trim) { return 'blank' }
    if (Is-Separator $trim) { return 'separator' }
    if ($trim -match '^>') { return 'quote' }
    if ($trim -match '^https?://') { return 'url' }

    if ($trim -match '^#{1,6}\s+\S') {
        $text = ($trim -replace '^#{1,6}\s+', '').Trim()
        if ((Is-Codeish $text) -or $text -match '^(default:|description:|Port:|ListenAddress:|PermitRootLogin:|PasswordAuthentication:|PubkeyAuthentication:|AuthorizedKeysFile:)') {
            return 'code'
        }
        if ($text.Length -le 90 -and $text -notmatch '[.!?]$' -and $text -notmatch $PagePattern) {
            return 'heading'
        }
        return 'text'
    }

    if ($trim -match '^\|.+\|$') { return 'table' }
    if ($trim -match '^\s*[-*+]\s+\S') { return 'bullet' }
    if (Is-Codeish $Line) { return 'code' }
    return 'text'
}

function Infer-CodeLanguage([string[]]$Lines) {
    if ($Lines.Count -eq 0) { return '' }

    $commandCount = 0
    $configCount = 0
    $outputCount = 0
    $cronCount = 0

    foreach ($line in $Lines) {
        if (Is-CommandStart $line) { $commandCount++ }
        if (Is-ConfigLine $line) { $configCount++ }
        if (Is-OutputLine $line) { $outputCount++ }
        if (Is-CronLine $line) { $cronCount++ }
    }

    if ($cronCount -gt 0 -and $commandCount -eq 0) { return 'cron' }
    if ($outputCount -gt 0 -and $outputCount -ge $commandCount -and $outputCount -ge $configCount) { return '' }
    if ($configCount -gt 0 -and $commandCount -eq 0) { return 'conf' }
    if ($commandCount -gt 0) { return 'bash' }
    if ($configCount -gt 0) { return 'conf' }
    return ''
}

function Should-BeSubheading([string[]]$Lines, [string]$NextKind, [string]$DocType) {
    $joined = (($Lines | ForEach-Object { $_.Trim() }) -join ' ').Trim()
    if (-not $joined) { return $false }
    if ($joined -match $PagePattern) { return $false }
    if ($joined -match '^https?://') { return $false }
    if ($joined -match '[.!?]$') { return $false }
    if ($joined.Length -gt 90) { return $false }
    if ($Lines.Count -gt 2) { return $false }
    if ($NextKind -notin @('code', 'bullet', 'text', 'table', 'quote')) { return $false }
    if ($DocType -in @('lab', 'exercise')) { return $joined -match '^[A-Z0-9]' }
    return $Lines.Count -eq 1
}

function Is-ReferenceText([string]$Paragraph) {
    return $Paragraph -match $PagePattern
}

function Pick-Title([string]$FallbackTitle) {
    return (Clean-Title $FallbackTitle)
}

function Get-DocumentStats([string]$Content) {
    $firstNonEmpty = ''
    foreach ($line in ($Content -replace "`r`n?", "`n" -split "`n")) {
        if ($line.Trim()) {
            $firstNonEmpty = $line.Trim()
            break
        }
    }

    return [pscustomobject]@{
        FirstNonEmpty = $firstNonEmpty
        HeadingCount  = [regex]::Matches($Content, '(?m)^#{1,6}\s+.+$').Count
        H1Count       = [regex]::Matches($Content, '(?m)^#\s+.+$').Count
        H2H3Count     = [regex]::Matches($Content, '(?m)^#{2,3}\s+.+$').Count
        FenceCount    = [regex]::Matches($Content, '(?m)^```').Count
        TableCount    = [regex]::Matches($Content, '(?m)^\|.+\|$').Count
        NumberedCount = [regex]::Matches($Content, '(?m)^\d+\.\s+').Count
    }
}

function Normalize-Minimal([string]$Raw) {
    $text = $Raw -replace "`r`n?", "`n"
    $lines = $text -split "`n"
    $output = New-Object System.Collections.Generic.List[string]
    $lastBlank = $false

    foreach ($line in $lines) {
        $clean = $line.TrimEnd()
        if (-not $clean.Trim()) {
            if (-not $lastBlank) {
                $output.Add('')
            }
            $lastBlank = $true
            continue
        }

        $output.Add($clean)
        $lastBlank = $false
    }

    $normalized = ($output -join "`n")
    $normalized = $normalized.Trim() + "`n"
    return $normalized
}

function Render-LabTextBlock([string[]]$Lines) {
    $rendered = New-Object System.Collections.Generic.List[string]
    $index = 0

    while ($index -lt $Lines.Count) {
        $current = $Lines[$index].Trim()
        if (-not $current) {
            $index++
            continue
        }

        $isHeadingLine = $current.Length -le 90 -and $current -notmatch '[.!?]$' -and $current -match '^[A-Z0-9]'
        if ($isHeadingLine) {
            $rendered.Add('### ' + $current)
            $rendered.Add('')

            if ($index + 1 -lt $Lines.Count) {
                $next = $Lines[$index + 1].Trim()
                $nextIsHeading = $next -and $next.Length -le 90 -and $next -notmatch '[.!?]$' -and $next -match '^[A-Z0-9]'
                if ($next -and -not $nextIsHeading -and -not (Is-Codeish $next)) {
                    $rendered.Add($next)
                    $rendered.Add('')
                    $index += 2
                    continue
                }
            }

            $index++
            continue
        }

        $rendered.Add($current)
        $rendered.Add('')
        $index++
    }

    return @($rendered)
}

function Normalize-Content([string]$RelativePath) {
    $fullPath = Join-Path $Root $RelativePath
    $raw = Read-Text $fullPath

    $text = $raw -replace "`r`n?", "`n"
    $text = $text -replace [char]0x00A0, ' '
    $text = $text -replace ("\s+" + [regex]::Escape($BulletChar) + "\s+"), "`n- "
    $text = $text -replace ("\s+" + [regex]::Escape($MidDotChar) + "\s+"), "`n- "
    $text = $text.Trim() + "`n"

    $blocks = New-Object System.Collections.Generic.List[object]
    $buffer = New-Object System.Collections.Generic.List[string]
    $currentKind = $null
    $inFence = $false
    $fenceLines = New-Object System.Collections.Generic.List[string]

    function Flush-CurrentBuffer {
        if ($buffer.Count -gt 0 -and $currentKind) {
            $blocks.Add([pscustomobject]@{
                Kind  = $currentKind
                Lines = @($buffer)
            })
            Set-Variable -Scope 1 -Name buffer -Value (New-Object System.Collections.Generic.List[string])
            Set-Variable -Scope 1 -Name currentKind -Value $null
        }
    }

    foreach ($originalLine in ($text -split "`n")) {
        $line = Normalize-Line $originalLine

        if ($line.TrimStart() -match '^```') {
            if ($inFence) {
                $fenceLines.Add($line)
                $blocks.Add([pscustomobject]@{
                    Kind  = 'fence'
                    Lines = @($fenceLines)
                })
                $fenceLines = New-Object System.Collections.Generic.List[string]
                $inFence = $false
            }
            else {
                Flush-CurrentBuffer
                $inFence = $true
                $fenceLines.Add($line)
            }
            continue
        }

        if ($inFence) {
            $fenceLines.Add($line)
            continue
        }

        $kind = Get-LineKind $line

        if ($kind -eq 'blank') {
            Flush-CurrentBuffer
            continue
        }

        if ($kind -in @('heading', 'separator')) {
            Flush-CurrentBuffer
            $blocks.Add([pscustomobject]@{
                Kind  = $kind
                Lines = @($line)
            })
            continue
        }

        if (-not $currentKind -or $currentKind -ne $kind) {
            Flush-CurrentBuffer
            $currentKind = $kind
        }

        $buffer.Add($line)
    }

    Flush-CurrentBuffer

    $title = Pick-Title $RelativePath
    $docType = Get-DocType ([IO.Path]::GetFileName($RelativePath))
    $intro = Get-Intro $docType $title
    $meaningfulHeadings = @(
        $blocks | Where-Object {
            $_.Kind -eq 'heading' -and
            (($_.Lines[0] -replace '^#{1,6}\s+', '').Trim()) -notmatch ('(?i)^' + [regex]::Escape($title) + '$')
        }
    )
    $needsMainSection = $meaningfulHeadings.Count -eq 0
    $mainSectionTitle = if ($docType -in @('lab', 'exercise')) { '## Desarrollo' } else { '## Contenido' }

    $output = New-Object System.Collections.Generic.List[string]
    $output.Add('# ' + $title)
    $output.Add('')
    $output.Add($intro)
    $output.Add('')

    if ($needsMainSection) {
        $output.Add($mainSectionTitle)
        $output.Add('')
    }

    $referencesOpen = $false

    for ($i = 0; $i -lt $blocks.Count; $i++) {
        $block = $blocks[$i]
        $nextKind = if ($i + 1 -lt $blocks.Count) { $blocks[$i + 1].Kind } else { '' }

        switch ($block.Kind) {
            'heading' {
                $headingText = ($block.Lines[0] -replace '^#{1,6}\s+', '').Trim()
                if (-not $headingText) { continue }
                if ($headingText -match ('(?i)^' + [regex]::Escape($title) + '$')) { continue }
                if (Is-ReferenceText $headingText) {
                    $output.Add('> ' + $headingText)
                }
                else {
                    $output.Add('## ' + $headingText)
                }
                $output.Add('')
            }
            'separator' {
                if ($output.Count -gt 0 -and $output[$output.Count - 1] -ne '') {
                    $output.Add('')
                }
                $output.Add('---')
                $output.Add('')
            }
            'url' {
                if (-not $referencesOpen) {
                    $output.Add('## Referencias')
                    $output.Add('')
                    $referencesOpen = $true
                }
                foreach ($line in $block.Lines) {
                    $output.Add('- ' + $line.Trim())
                }
                $output.Add('')
            }
            'quote' {
                foreach ($line in $block.Lines) {
                    $output.Add($line.TrimEnd())
                }
                $output.Add('')
            }
            'bullet' {
                foreach ($line in $block.Lines) {
                    $textLine = ($line.Trim() -replace '^[-*+]\s+', '').Trim()
                    $output.Add('- ' + $textLine)
                }
                $output.Add('')
            }
            'table' {
                foreach ($line in $block.Lines) {
                    $output.Add($line.TrimEnd())
                }
                $output.Add('')
            }
            'fence' {
                foreach ($line in $block.Lines) {
                    $output.Add($line.TrimEnd())
                }
                $output.Add('')
            }
            'code' {
                $lang = Infer-CodeLanguage $block.Lines
                $output.Add('```' + $lang)
                foreach ($line in $block.Lines) {
                    $output.Add($line.TrimEnd())
                }
                $output.Add('```')
                $output.Add('')
            }
            'text' {
                if ($docType -in @('lab', 'exercise') -and $block.Lines.Count -gt 1) {
                    foreach ($line in (Render-LabTextBlock $block.Lines)) {
                        $output.Add($line)
                    }
                    continue
                }

                if (Should-BeSubheading $block.Lines $nextKind $docType) {
                    $heading = (($block.Lines | ForEach-Object { $_.Trim() }) -join ' ').Trim()
                    $output.Add('### ' + $heading)
                    $output.Add('')
                    continue
                }

                $paragraph = (($block.Lines | ForEach-Object { $_.Trim() }) -join ' ').Trim()
                if (-not $paragraph) { continue }

                if (Is-ReferenceText $paragraph) {
                    $output.Add('> ' + ($paragraph -replace '^#{1,6}\s+', ''))
                }
                else {
                    $output.Add($paragraph)
                }
                $output.Add('')
            }
        }
    }

    $normalized = ($output -join "`n")
    $normalized = $normalized -replace "(`n){3,}", "`n`n"
    $normalized = $normalized.Trim() + "`n"
    return $normalized
}

function Normalize-File([string]$RelativePath, [string]$CurrentContent) {
    $stats = Get-DocumentStats $CurrentContent
    $wellStructured = $stats.FirstNonEmpty -match '^#\s+' -and $stats.H2H3Count -ge 3 -and (
        $stats.FenceCount -ge 4 -or
        $stats.TableCount -ge 2 -or
        $stats.NumberedCount -ge 5
    )

    if ($wellStructured) {
        return (Normalize-Minimal $CurrentContent)
    }

    return (Normalize-Content -RelativePath $RelativePath)
}

if ($Preview) {
    $relative = Resolve-Path -LiteralPath (Join-Path $Root $Preview) | ForEach-Object {
        $_.Path.Substring($Root.Length + 1)
    }
    $current = Read-Text (Join-Path $Root $relative)
    Normalize-File -RelativePath $relative -CurrentContent $current
    exit 0
}

$files = Get-ChildItem -LiteralPath $Root -Recurse -File -Filter *.md | Sort-Object FullName
$changed = 0

foreach ($file in $files) {
    $relative = $file.FullName.Substring($Root.Length + 1)
    $current = Read-Text $file.FullName
    $normalized = Normalize-File -RelativePath $relative -CurrentContent $current
    if ($current -ne $normalized) {
        if ($Apply) {
            Write-Text -Path $file.FullName -Content $normalized
        }
        $changed++
    }
}

if ($Apply) {
    "Changed files: $changed"
}
else {
    "Files that would change: $changed"
}
