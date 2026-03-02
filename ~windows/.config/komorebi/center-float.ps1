Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

    [DllImport("user32.dll")]
    public static extern IntPtr MonitorFromWindow(IntPtr hwnd, uint dwFlags);

    [DllImport("user32.dll")]
    public static extern bool GetMonitorInfo(IntPtr hMonitor, ref MONITORINFO lpmi);

    [StructLayout(LayoutKind.Sequential)]
    public struct RECT { public int Left, Top, Right, Bottom; }

    [StructLayout(LayoutKind.Sequential)]
    public struct MONITORINFO {
        public int cbSize;
        public RECT rcMonitor;
        public RECT rcWork;
        public uint dwFlags;
    }
}
"@

$hwnd = [WinAPI]::GetForegroundWindow()

# Check if the focused window is currently floating in komorebi
$state      = komorebic state | ConvertFrom-Json
$hwndInt    = $hwnd.ToInt64()
$isFloating = $false

foreach ($mon in $state.monitors.elements) {
    foreach ($ws in $mon.workspaces.elements) {
        foreach ($fw in $ws.floating_windows) {
            if ($fw.hwnd -eq $hwndInt) { $isFloating = $true; break }
        }
    }
}

if ($isFloating) {
    # Already floating — tile it back and retile the layout
    komorebic toggle-float
    Start-Sleep -Milliseconds 100
    komorebic retile
} else {
    # Tiled — float it, then center with near-maximized height
    komorebic toggle-float
    Start-Sleep -Milliseconds 100

    $monitor = [WinAPI]::MonitorFromWindow($hwnd, 2)
    $mi = New-Object WinAPI+MONITORINFO
    $mi.cbSize = [System.Runtime.InteropServices.Marshal]::SizeOf($mi)
    [WinAPI]::GetMonitorInfo($monitor, [ref]$mi) | Out-Null

    $work   = $mi.rcWork
    $sw     = $work.Right  - $work.Left
    $sh     = $work.Bottom - $work.Top

    $width  = [int]($sw * 0.50)
    $height = [int]($sh * 0.96)
    $x      = $work.Left + [int](($sw - $width)  / 2)
    $y      = $work.Top  + [int](($sh - $height) / 2)

    [WinAPI]::SetWindowPos($hwnd, [IntPtr]::Zero, $x, $y, $width, $height, 0x0004) | Out-Null
}


