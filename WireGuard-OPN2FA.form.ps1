. 'c:\Users\Infraspread\GIT\WireGuard-OPNsense2FA\WireGuard-OPN2FA.ps1'
Add-Type -AssemblyName System.Windows.Forms
$btn_Click = {
	VPNLogout -text $txttext.Text -title $txttitle.Text -CaptiveURL $txtCaptiveURL.Text 
}
. 'c:\Users\Infraspread\GIT\WireGuard-OPNsense2FA\WireGuard-OPN2FA.form.designer.ps1'
$Form1.ShowDialog()
