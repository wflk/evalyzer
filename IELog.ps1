$path = split-path -parent $MyInvocation.MyCommand.Definition
$dbg = (gci -recurse 'C:\Program Files\Windows Kits' "ntsd.exe").FullName
if(!$dbg) { $dbg= (gci -recurse 'C:\Program Files (x86)\Windows Kits' "ntsd.exe").FullName}
if(!$dbg) { "Cannot find NTSD.exe. Is WinDBG installed?"; exit}
$iePID=(gwmi Win32_Process -filter "name = 'iexplore.exe'" | sort -property CreationTime -descending | ? {$_.CommandLine -match "SCODEF"} | select ProcessID -first 1).ProcessID
if($iePID) 
{
    & $dbg -cfr $path"\"ie11_eval.wds -G -hd -p $iePID 
}
else 
{
    echo "Cannot find running IE tab!"
}

