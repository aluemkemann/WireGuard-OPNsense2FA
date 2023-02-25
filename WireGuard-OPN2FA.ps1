function VPNLogout($text, $title, $CaptiveURL) {
    $headers = @{
        "Accept"           = "application/json, text/javascript, */*; q=0.01"
        "Accept-Encoding"  = "gzip, deflate"
        "Accept-Language"  = "en-GB,en;q=0.9,en-US;q=0.8,de;q=0.7"
        "DNT"              = "1"
        "Origin"           = "$OriginURL"
        "Referer"          = "$OriginURL/"
        "X-Requested-With" = "XMLHttpRequest"
    }
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.56"
    if ($IsLinux) {
        Invoke-WebRequest -UseBasicParsing -TimeoutSec 3 -Uri $CaptiveURL -Method "POST" -WebSession $session -Headers $headers -ContentType "application/x-www-form-urlencoded; charset=UTF-8" -Body "user=&password="
    }
    else {
        if ($IsWindows) {
            $a = New-Object -ComObject wscript.shell
            $b = $a.popup($text, 0, $title, 0)
            Invoke-WebRequest -UseBasicParsing -TimeoutSec 3 -Uri $CaptiveURL -Method "POST" -WebSession $session -Headers $headers -ContentType "application/x-www-form-urlencoded; charset=UTF-8" -Body "user=&password="
        }
    }
}

function VPNLogin {
    param (
        [string]$CaptiveServer = "10.0.0.1",
        [string]$CaptivePort = "8000",
        [string]$CaptiveZone = "0",
        [bool]$SSL,
        [string]$username,
        [string]$CombinedPassOTP
    )
    
    CheckServer -Server $CaptiveServer -Port $CaptivePort -Terminate $true
    
    if ($SSL) {
        $Protocol = "https"
    }
    else {
        $Protocol = "http"
    }
    
    $action = "logon"
    $CaptiveURL = "$Protocol" + "://$CaptiveServer" + ":$CaptivePort/api/captiveportal/access/$action/$CaptiveZone/"
    $OriginURL = "$Protocol" + "://$CaptiveServer" + ":$CaptivePort"
     
    if ("$null" -eq "$username") {
        if ($isLinux) {
            "Linux username null"
            $username = $env:USER.ToLower()
            "Linux username now $username"
        }
        if ($IsWindows) {
            "Windows username null"
            $username = $env:USERNAME.ToLower()
            "Windows username now $username"
        }
    }
  
    if ($CombinedPassOTP -eq "") {
        if ($isLinux) {
            "Linux Credential is null"
            $CombinedPassOTP = (Read-Host -Prompt "Passwort von Benutzer $username und OTP Token - ohne Leerzeichen - eingeben")
            "Linux Credential now $Credential"
        }
        else {
            if ($IsWindows) {
                "Windows Credential is null"
                [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
                $title = "Wireguard VPN 2FA Authentication"
                $msg = "Passwort von Benutzer $username direkt gefolgt vom OTP Token eingeben"
                #Hide-Console
                $CombinedPassOTP = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
                "Windows Credential is now $Credential"
            }
        }
    }

    $headers = @{
        "Accept"           = "application/json, text/javascript, */*; q=0.01"
        "Accept-Encoding"  = "gzip, deflate"
        "Accept-Language"  = "en-GB,en;q=0.9,en-US;q=0.8,de;q=0.7"
        "DNT"              = "1"
        "Origin"           = "$OriginURL"
        "Referer"          = "$OriginURL/"
        "X-Requested-With" = "XMLHttpRequest"
    }

    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.56"
    $ContentType = "application/x-www-form-urlencoded; charset=UTF-8"
    $body = "user=$($username)&password=$($CombinedPassOTP)"
    $LoginResult = Invoke-WebRequest -UseBasicParsing -TimeoutSec 3 -Uri $CaptiveURL -Method "POST" -WebSession $session -Headers $headers -ContentType "$ContentType" -Body "$body"
    $LoginStatus = ($LoginResult.Content | ConvertFrom-Json).clientState
    Write-Host $LoginStatus
    if ($LoginStatus -eq "AUTHORIZED") {
        ## Show 2FA Logout Button ##
        if ($IsWindows) {
            $action = "logoff"
            $CaptiveURL = "$Protocol" + "://$CaptiveServer" + ":$CaptivePort/api/captiveportal/access/$action/$CaptiveZone/"
            VPNLogout "VPN Abmelden" "VPN Abmelden" "$($CaptiveURL)"
        }
    }
}


if ($IsWindows) {
    Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'
}

if ($IsWindows) {
    function Hide-Console {
        $consolePtr = [Console.Window]::GetConsoleWindow()
        #0 hide
        [Console.Window]::ShowWindow($consolePtr, 0)
    }
    #Hide-Console
}

function CheckServer {
    param (
        [string]
        [Parameter(Mandatory, HelpMessage = 'Server to check')]
        $Server,
        [string]
        [Parameter(Mandatory, HelpMessage = 'Port on Server')]
        $Port,
        [bool]
        [Parameter(HelpMessage = 'Terminate if unreachable')]
        $Terminate
    )
    $CheckResult = (Test-Connection -IPv4 -TargetName $Server -TcpPort $Port -Quiet)
    if ($CheckResult) {
        Write-Host "Verbindung mit $Server auf Port $Port erfolgreich" -ForegroundColor Green -BackgroundColor Black
    }
    else {
        Write-Host "Fehler: Kann keine Verbindung mit $Server auf Port $Port herstellen!" -ForegroundColor Red -BackgroundColor Black
        if ($Terminate) {
            Write-Host "Programmabbruch!" -ForegroundColor Red -BackgroundColor Yellow
            break
        }
    }
    return $CheckResult
}


## If started without Command Line Arguments, run with defaults
if ($null -eq $Args[0]) {
    Write-Host "Script ohne Parameter gestartet, nutze Default Set"
    if ($isLinux) {
        $CaptiveServer = (Read-Host -Prompt "Wireguard Server Namen oder IP eingeben")
    }
    else {
        if ($IsWindows) {
            [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
            $title = "Wireguard VPN 2FA Authentication"
            $msg = "Wireguard Server Namen oder IP eingeben"
            #Hide-Console
            $CaptiveServer = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
        }
    }
}

VPNLogin -CaptiveServer $CaptiveServer -username $env:USERNAME.ToLower()