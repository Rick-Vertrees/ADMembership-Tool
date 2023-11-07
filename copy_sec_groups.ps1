#Generated Form Function
function GenerateForm {
    Import-Module ActiveDirectory
    
    #region Import the Assemblies
    [reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
    [reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
    #endregion
    
    #region Generated Form Objects
    $form1 = New-Object System.Windows.Forms.Form
    $bclear = New-Object System.Windows.Forms.Button
    $membership = New-Object System.Windows.Forms.CheckedListBox
    $selectall = New-Object System.Windows.Forms.Button
    $deselectall = New-Object System.Windows.Forms.Button
    $bcopy = New-Object System.Windows.Forms.Button
    $label4 = New-Object System.Windows.Forms.Label
    $label3 = New-Object System.Windows.Forms.Label
    $label2 = New-Object System.Windows.Forms.Label
    $label1 = New-Object System.Windows.Forms.Label
    $sourceSearchText = New-Object System.Windows.Forms.TextBox
    $targetSearchText = New-Object System.Windows.Forms.TextBox
    $universalOutput = New-Object System.Windows.Forms.TextBox
    $universalOutput = New-Object System.Windows.Forms.TextBox
    $bsourceSearch = New-Object System.Windows.Forms.Button
    $btargetSearch = New-Object System.Windows.Forms.Button
    $sourceSearch = New-Object System.Windows.Forms.CheckedListBox
    $targetSearch = New-Object System.Windows.Forms.CheckedListBox
    $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
    #endregion Generated Form Objects
    
    #----------------------------------------------
    #Generated Event Script Blocks
    #----------------------------------------------

    $global:sourceOutput = ""
    $global:targetOutput = ""

    #Disable Source User CheckedListBox upon selection
    function SourceMaxChecked()
    {

        $checkedCount = $sourceSearch.CheckedItems.count
        If($_.NewValue -eq "Checked"){
            $checkedCount += 1
        }
        Else{
            $checkedCount += -1
            $i = $membership.Items.Count - 1
            while($i -ne -1) {$membership.items.remove($membership.items[$i]) 
            $i--}
        }
        
        if($checkedCount -gt 1){
            $_.NewValue = $_.CurrentValue            
        }
        Else{
            If($global:sourceCount){
            $global:indexcopy = $_.Index
            $global:iuser1 = $global:sourceProfiles[$indexcopy]
            $global:user1 = $iuser1
            }
            Else{
                $global:user1 = $global:sourceProfiles
                }
            $firstName = $user1.GivenName
            $lastName = $user1.Surname
            $title = $user1.title
            $department = $user1.Department
            $company = $user1.Company
            $mail = $global:user1.mail
            $DN = $user1.DistinguishedName
            $global:sourceOutput = ""
            $global:sourceOutput += "=========================Source Info========================= `r`n"
            $global:sourceOutput += "Firstname: $firstName `r`n"
            $global:sourceOutput += "Lastname: $lastName `r`n"
            $global:sourceOutput += "Email: $mail `r`n"
            $global:sourceOutput += "Title: $title `r`n"
            $global:sourceOutput += "Department: $department `r`n"
            $global:sourceOutput += "Company: $company `r`n"
            $global:sourceOutput += "DN: $DN `r`n"
        }
        If($_.NewValue -eq "Checked"){
            $arrgroups = (Get-ADPrincipalGroupMembership $global:user1.SAMAccountName)
            foreach($group in $arrgroups) {
                if($group.name -eq "Domain Users") {
                }
                Else{
                    $membership.items.add($group.Name)
                   }
            }
        }
        $universalOutput.Text = $global:sourceOutput + $global:targetOutput
    }

    #Disable Target User CheckedListBox upon selection
    function TargetMaxChecked()
    {
        $global:TargetUsers = @()
        [System.Collections.ArrayList]$global:checkedIndecies = @()
        $global:targetOutput = ""
        $checkedCount = $targetSearch.CheckedItems.count
        Foreach($index in $targetSearch.CheckedIndices) {
            $global:checkedIndecies += $index
        }
        If($_.NewValue -eq "Checked"){
            $checkedCount += 1
            $global:checkedIndecies += $_.index
        }
        Else{
            $checkedCount += -1
            $global:checkedIndecies.remove($_.index)
        }
        
        if($checkedCount -gt 10){
            $_.NewValue = $_.CurrentValue            
        }
        Else{

            If($global:targetCount) {
                $i=0
                Foreach($checkedindex in $checkedIndecies) {
                    $i += 1
                    $global:iuser2 = $global:targetProfiles[$checkedIndex]
                    $global:user2 = $iuser2
                    $firstName = $user2.GivenName
                    $lastName = $user2.Surname
                    $title = $user2.title
                    $department = $user2.Department
                    $company = $user2.Company
                    $mail = $global:user2.mail
                    $DN = $user2.DistinguishedName
                    $global:targetOutput += "=========================Target" + $i + "Info========================= `r`n"
                    $global:targetOutput += "Firstname: $firstName `r`n"
                    $global:targetOutput += "Lastname: $lastName `r`n"
                    $global:targetOutput += "Email: $mail `r`n"
                    $global:targetOutput += "Title: $title `r`n"
                    $global:targetOutput += "Department: $department `r`n"
                    $global:targetOutput += "Company: $company `r`n"
                    $global:targetOutput += "DN: $DN `r`n"
                    $global:TargetUsers += $user2
                }
            }
            Else{
                $global:user1 = $global:targetProfiles
                $firstName = $user2.GivenName
                $lastName = $user2.Surname
                $title = $user2.title
                $department = $user2.Department
                $company = $user2.Company
                $mail = $global:user2.mail
                $DN = $user2.DistinguishedName
                $global:targetOutput += "=========================Target Info========================= `r`n"
                $global:targetOutput += "Firstname: $firstName `r`n"
                $global:targetOutput += "Lastname: $lastName `r`n"
                $global:targetOutput += "Email: $mail `r`n"
                $global:targetOutput += "Title: $title `r`n"
                $global:targetOutput += "Department: $department `r`n"
                $global:targetOutput += "Company: $company `r`n"
                $global:targetOutput += "DN: $DN `r`n"
                $global:TargetUsers += $user2
                }
       
        }
        $universalOutput.Text = $global:sourceOutput + $global:targetOutput
    }

    #Search AD for a name similar to what was entered into the source user text box
    $OUs = <Top level User OU>
    $bsourceSearch_OnClick =
    {
        $global:sourceProfiles = @()
        $i = $sourceSearch.Items.Count - 1
        while($i -ne -1) {$sourceSearch.items.remove($sourceSearch.items[$i]) 
        $i--}
        $sourceName = $sourceSearchText.Text
        $sourceName = $sourceName -replace ".{1}$"
        Foreach($OU in $OUs) {        

            $global:sourceProfiles += Get-ADUser -SearchBase $OU -Filter "Name -like '*$sourceName*'" -Properties * | Select-Object
            
        }
        $global:sourceCount = $global:sourceProfiles.count
        foreach($source in $global:sourceProfiles) {
            $username = $source.name
            $sourceSearch.Items.Add($username)
            }
        }
    
    #Search AD for a name similar to what was entered into the target user text box
    $btargetSearch_OnClick =
    {
        $global:targetProfiles = @()
        $i = $targetSearch.Items.Count - 1
        while($i -ne -1) {
            if($global:checkedIndecies.contains($i)) {
                $i--
            }
            Else{
                $targetSearch.items.remove($targetSearch.items[$i]) 
                $i--
            }
        }
        If($targetSearch.CheckedItems) {
            $ExistingUsers = $targetSearch.CheckedItems
            ForEach($User in $ExistingUsers) {
                $global:targetProfiles += Get-ADUser -Filter "Name -eq '$User'" -Properties * | Select-Object
            }
        }
        $targetName = $targetSearchText.Text
        $targetName = $targetName -replace ".{1}$"
        If($targetName) {
            Foreach($OU in $OUs) {

                $global:targetProfiles += Get-ADUser -SearchBase $OU -Filter "Name -like '*$targetName*'" -Properties *| Select-Object
                

            }
        }
        Else{
            $global:targetProfiles = Get-ADUser -SearchBase "OU=Okta Staging Preview,OU=Users,OU=RP,DC=radpartners,DC=com" -SearchScope Base -Filter * -Properties *| Select-Object
            }
        $global:targetCount = $global:targetProfiles.count
        foreach($target in $global:targetProfiles) {
            $username2 = $target.name
            if(!$targetSearch.Items.Contains($username2)) {
                $targetSearch.Items.Add($username2)
            }
        }

    }

        
    $bcopy_OnClick= 
    {
    $copyOutput = "==================================================`r`n"
    #Checking the Checkboxlist for all Checked Items
    
    $arrindexgrp = $membership.checkeditems
    $membership.enabled = $False
    
    #Adding User to each Group checked
    
     foreach($group in $arrindexgrp)
        {
        foreach($user in $global:targetUsers) { 
            Try 
                {
                Add-ADGroupMember -Identity "$group" -Members $user -ErrorAction Stop
    
                } 
            Catch [Microsoft.ActiveDirectory.Management.ADException]
                {
                $copyOutput += "Failed to add $user to the Group: $group `r`n"
                 Continue
                }
        }
     }
    
    $universalOutput.Text = $global:sourceOutput + $global:targetOutput + $copyOutput
    }
    

    
    $bclear_OnClick= 
    {
    #Clearing fields
    $targetSearch.enabled = $True
    $sourceSearch.enabled = $True
    $targetSearch.SelectedIndex = -1
    $sourceSearch.SelectedIndex = -1
    $sourceSearchText.Text = ""
    $targetSearchText.Text = ""
    $universalOutput.Text = ""
    
    # Clear CheckedListBox
    $i = $membership.Items.Count - 1
    while($i -ne -1) {$membership.items.remove($membership.items[$i]) 
    $i--}

    $i = $sourceSearch.Items.Count - 1
    while($i -ne -1) {$sourceSearch.items.remove($sourceSearch.items[$i]) 
    $i--}

    $i = $targetSearch.Items.Count - 1
    while($i -ne -1) {$targetSearch.items.remove($targetSearch.items[$i]) 
    $i--}

    }

    $SelectAll_OnClick=
    {
    #Select All
        $i = ($membership.Items.Count) - 1
        while($i -ne -1) {
            $membership.SetItemChecked($i,$true)
            $i--
        }
    }

    $DeselectAll_OnClick=
    {
    #Select All
        $i = ($membership.Items.Count) - 1
        while($i -ne -1) {
            $membership.SetItemChecked($i,$False)
            $i--
        }
    }
    
    #Enabling Combo, Checklist, Textbox and Button
    $targetSearch.enabled = $true
    $sourceSearch.enabled = $true
    $membership.enabled = $true
    $selectall.visible = $true
    $deselectall.visible = $true
    $bsourceSearch.visible = $true
    $bclear.visible = $true
        
    $OnLoadForm_StateCorrection=
    {#Correct the initial state of the form to prevent the .Net maximized form issue
        $form1.WindowState = $InitialFormWindowState
    }
    
    #----------------------------------------------
    #region Generated Form Code
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 600
    $System_Drawing_Size.Width = 500
    $form1.ClientSize = $System_Drawing_Size
    $form1.DataBindings.DefaultDataSourceUpdateMode = 0
    $form1.Name = "form1"
    $form1.Text = "Membership Transfer"
    
    $bclear.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 360
    $System_Drawing_Point.Y = 55
    $bclear.Location = $System_Drawing_Point
    $bclear.Name = "bclear"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 30
    $System_Drawing_Size.Width = 126
    $bclear.Size = $System_Drawing_Size
    $bclear.TabIndex = 7
    $bclear.Text = "Clear"
    $bclear.UseVisualStyleBackColor = $True
    $bclear.add_Click($bclear_OnClick)
    
    $form1.Controls.Add($bclear)
    
    $membership.DataBindings.DefaultDataSourceUpdateMode = 0
    $membership.FormattingEnabled = $True
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 230
    $membership.Location = $System_Drawing_Point
    $membership.Name = "membership"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 200
    $System_Drawing_Size.Width = 450
    $membership.Size = $System_Drawing_Size
    
    $form1.Controls.Add($membership)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 100
    $System_Drawing_Point.Y = 205
    $selectall.Location = $System_Drawing_Point
    $selectall.Name = "selectall"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 75
    $selectall.Size = $System_Drawing_Size
    $selectall.TabIndex = 5
    $selectall.Text = "Check All"
    $selectall.UseVisualStyleBackColor = $True
    $selectall.add_Click($SelectAll_OnClick)
    
    $form1.Controls.Add($selectall)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 180
    $System_Drawing_Point.Y = 205
    $deselectall.Location = $System_Drawing_Point
    $deselectall.Name = "deselectall"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 75
    $deselectall.Size = $System_Drawing_Size
    $deselectall.TabIndex = 6
    $deselectall.Text = "Uncheck All"
    $deselectall.UseVisualStyleBackColor = $True
    $deselectall.add_Click($DeselectAll_OnClick)
    
    $form1.Controls.Add($deselectall)
    
    
    $bcopy.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 360
    $System_Drawing_Point.Y = 20
    $bcopy.Location = $System_Drawing_Point
    $bcopy.Name = "bcopy"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 30
    $System_Drawing_Size.Width = 126
    $bcopy.Size = $System_Drawing_Size
    $bcopy.TabIndex = 8
    $bcopy.Text = "Copy"
    $bcopy.UseVisualStyleBackColor = $True
    $bcopy.add_Click($bcopy_OnClick)
    
    $form1.Controls.Add($bcopy)

    $label4.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 435
    $label4.Location = $System_Drawing_Point
    $label4.Name = "label4"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 100
    $label4.Size = $System_Drawing_Size
    $label4.Text = "Output "

    $form1.Controls.Add($label4)
    
    $label3.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 205
    $label3.Location = $System_Drawing_Point
    $label3.Name = "label3"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 252
    $label3.Size = $System_Drawing_Size
    $label3.Text = "Membership "
    
    $form1.Controls.Add($label3)
    
    $label2.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 50
    $label2.Location = $System_Drawing_Point
    $label2.Name = "label2"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 139
    $label2.Size = $System_Drawing_Size
    $label2.Text = "Source User"
    
    $form1.Controls.Add($label2)
    
    $label1.DataBindings.DefaultDataSourceUpdateMode = 0
    
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 185
    $System_Drawing_Point.Y = 50
    $label1.Location = $System_Drawing_Point
    $label1.Name = "label1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 139
    $label1.Size = $System_Drawing_Size
    $label1.Text = "Target User"
    
    $form1.Controls.Add($label1)
    
    $sourceSearch.DataBindings.DefaultDataSourceUpdateMode = 0
    $sourceSearch.FormattingEnabled = $True
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 75
    $sourceSearch.Location = $System_Drawing_Point
    $sourceSearch.Name = "sourceSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 125
    $System_Drawing_Size.Width = 150
    $sourceSearch.Size = $System_Drawing_Size
    $sourceSearch.Add_ItemCheck({SourceMaxChecked})

    $form1.Controls.Add($sourceSearch)
    
    $targetSearch.DataBindings.DefaultDataSourceUpdateMode = 0
    $targetSearch.FormattingEnabled = $True
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 185
    $System_Drawing_Point.Y = 75
    $targetSearch.Location = $System_Drawing_Point
    $targetSearch.Name = "targetSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 125
    $System_Drawing_Size.Width = 150
    $targetSearch.Size = $System_Drawing_Size
    $targetSearch.Add_ItemCheck({TargetMaxChecked})
    
    $form1.Controls.Add($targetSearch)

    $sourceSearchText.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 20
    $sourceSearchText.Location = $System_Drawing_Point
    $sourceSearchText.Name = "sourceSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 95
    $sourceSearchText.Size = $System_Drawing_Size
    $sourceSearchText.TabIndex = 0
    
    $form1.Controls.Add($sourceSearchText)

    $targetSearchText.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 185
    $System_Drawing_Point.Y = 20
    $targetSearchText.Location = $System_Drawing_Point
    $targetSearchText.Name = "sourceSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 95
    $targetSearchText.Size = $System_Drawing_Size
    $targetSearchText.TabIndex = 2
    
    $form1.Controls.Add($targetSearchText)

    $bsourceSearch.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 130
    $System_Drawing_Point.Y = 20
    $bsourceSearch.Location = $System_Drawing_Point
    $bsourceSearch.Name = "bsourceSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 50
    $bsourceSearch.Size = $System_Drawing_Size
    $bsourceSearch.TabIndex = 1
    $bsourceSearch.Text = "Search"
    $bsourceSearch.UseVisualStyleBackColor = $True
    $bsourceSearch.add_Click($bsourceSearch_OnClick)
    
    $form1.Controls.Add($bsourceSearch)

    $btargetSearch.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 285
    $System_Drawing_Point.Y = 20
    $btargetSearch.Location = $System_Drawing_Point
    $btargetSearch.Name = "btargetSearch"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 50
    $btargetSearch.Size = $System_Drawing_Size
    $btargetSearch.TabIndex = 3
    $btargetSearch.Text = "Search"
    $btargetSearch.UseVisualStyleBackColor = $True
    $btargetSearch.add_Click($btargetSearch_OnClick)
    
    $form1.Controls.Add($btargetSearch)

    $universalOutput.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 30
    $System_Drawing_Point.Y = 460
    $universalOutput.Location = $System_Drawing_Point
    $universalOutput.Name = "sourceUserInfo"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 135
    $System_Drawing_Size.Width = 450
    $universalOutput.Size = $System_Drawing_Size
    $universalOutput.TabIndex = 0
    $universalOutput.Multiline = $true
    $universalOutput.WordWrap = $false
    $universalOutput.ScrollBars = "Both"
    
    $form1.Controls.Add($universalOutput)
    
    #endregion Generated Form Code
    
    #Save the initial state of the form
    $InitialFormWindowState = $form1.WindowState
    #Init the OnLoad event to correct the initial state of the form
    $form1.add_Load($OnLoadForm_StateCorrection)
    #Show the Form
    $form1.ShowDialog()| Out-Null
    
    } #End Function
    
    #Call the Function
    GenerateForm
