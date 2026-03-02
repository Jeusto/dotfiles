$reg = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$current = Get-ItemPropertyValue $reg -Name AppsUseLightTheme
$new = if ($current -eq 1) { 0 } else { 1 }

Set-ItemProperty $reg -Name AppsUseLightTheme    -Value $new
Set-ItemProperty $reg -Name SystemUsesLightTheme -Value $new

# Broadcast the change so all apps update immediately
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class WinMsg {
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern IntPtr SendMessageTimeout(
        IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
        uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
}
"@
$result = [UIntPtr]::Zero
[WinMsg]::SendMessageTimeout(
    [IntPtr]0xFFFF, 0x001A, [UIntPtr]::Zero, "ImmersiveColorSet",
    0x0002, 5000, [ref]$result
) | Out-Null
