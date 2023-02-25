$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btn = $null
[System.Windows.Forms.Label]$lbltext = $null
[System.Windows.Forms.TextBox]$txttext = $null
[System.Windows.Forms.Label]$lbltitle = $null
[System.Windows.Forms.TextBox]$txttitle = $null
[System.Windows.Forms.Label]$lblCaptiveURL = $null
[System.Windows.Forms.TextBox]$txtCaptiveURL = $null
function InitializeComponent
{
$btn = (New-Object -TypeName System.Windows.Forms.Button)
$lbltext = (New-Object -TypeName System.Windows.Forms.Label)
$txttext = (New-Object -TypeName System.Windows.Forms.TextBox)
$lbltitle = (New-Object -TypeName System.Windows.Forms.Label)
$txttitle = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblCaptiveURL = (New-Object -TypeName System.Windows.Forms.Label)
$txtCaptiveURL = (New-Object -TypeName System.Windows.Forms.TextBox)
$form1.SuspendLayout()
#
# lbltext
#
$lbltext.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]10))
$lbltext.Name = [System.String]'lbltext'
$lbltext.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lbltext.TabIndex = 1
$lbltext.Text = 'text'
$lbltext.UseCompatibleTextRendering = $true
#
# txttext
#
$txttext.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]10))
$txttext.Name = [System.String]'txttext'
$txttext.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txttext.TabIndex = 2
#
# lbltitle
#
$lbltitle.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]40))
$lbltitle.Name = [System.String]'lbltitle'
$lbltitle.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lbltitle.TabIndex = 3
$lbltitle.Text = 'title'
$lbltitle.UseCompatibleTextRendering = $true
#
# txttitle
#
$txttitle.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]40))
$txttitle.Name = [System.String]'txttitle'
$txttitle.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txttitle.TabIndex = 4
#
# lblCaptiveURL
#
$lblCaptiveURL.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]70))
$lblCaptiveURL.Name = [System.String]'lblCaptiveURL'
$lblCaptiveURL.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblCaptiveURL.TabIndex = 5
$lblCaptiveURL.Text = 'CaptiveURL'
$lblCaptiveURL.UseCompatibleTextRendering = $true
#
# txtCaptiveURL
#
$txtCaptiveURL.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]70))
$txtCaptiveURL.Name = [System.String]'txtCaptiveURL'
$txtCaptiveURL.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtCaptiveURL.TabIndex = 6
#
# btn
#
$btn.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]220,[System.Int32]100))
$btn.Name = [System.String]'btn'
$btn.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$btn.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$btn.TabIndex = 7
$btn.Text = 'Submit'
$btn.UseVisualStyleBackColor = $true
$btn.add_Click($btn_Click)
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]380,[System.Int32]170))
$Form1.Controls.Add($lbltext)
$Form1.Controls.Add($txttext)
$Form1.Controls.Add($lbltitle)
$Form1.Controls.Add($txttitle)
$Form1.Controls.Add($lblCaptiveURL)
$Form1.Controls.Add($txtCaptiveURL)
$Form1.Controls.Add($btn)
$Form1.Text = [System.String]'Form1'
$Form1.ResumeLayout($true)
Add-Member -InputObject $Form1 -Name btn -Value $btn -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lbltext -Value $lbltext -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txttext -Value $txttext -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lbltitle -Value $lbltitle -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txttitle -Value $txttitle -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblCaptiveURL -Value $lblCaptiveURL -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtCaptiveURL -Value $txtCaptiveURL -MemberType NoteProperty
}
. InitializeComponent
