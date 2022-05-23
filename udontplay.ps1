# This script just looks for Ubisoft and Rainbow Six Siege services and kills them.
# By: MechMaster48 


# Checks to see which version of Rainbow Six Siege process is running (if any)
function Check-Rsix {

    $rainbowsix = Get-Process RainbowSix -ErrorAction SilentlyContinue
    $rainbowsixVkn = Get-Process RainbowSix_Vulkan -ErrorAction SilentlyContinue
    
    if (($rainbowsix -or $rainbowsixVkn) -ne $false) {
        if ($rainbowsix -ne $null) {
            return "RainbowSix"
        }
        else {
            return "RainbowSix_Vulkan"
        }
    }
    else {
        return $false
    }
}

# Checks to see if ubisoft core process is running
function Check-Ubi {
    $ubi = Get-Process upc -ErrorAction SilentlyContinue

    if ($ubi -ne $null) {
        return $true
    }
    else {
        return $false
    }
}

# Issues the response
function Give-Response  ($r6version, $UbiStatus){
    Write-Output "R6 is running $r6version, and status for Ubisoft Core is $UbiStatus"
    Write-Output "Killing Rainbow Six Siege and all things Ubisoft if they are running..."
    Write-Output "Done!"
}

# Stops the Ubisoft and Rainbow Six processes
function Kill-Rsix ($r6version){
    Stop-Process -Name $r6version -ErrorAction Continue
    Stop-Process -Name upc -ErrorAction Continue
}


$checkRsix = Check-Rsix
$checkUbi = Check-Ubi


# Give-Response $checkRsix $checkUbi

if (($checkUbi -eq $false) -and ($checkRsix -eq $false)) {
    Write-Output "It does not appear that Rainbow Six Siege is running or any Ubisoft garbage to support it."
    Write-Output "Done!"
}
elseif ($checkRsix -eq "RainbowSix_Vulkan") {
    Give-Response $checkRsix $checkUbi
    Kill-Rsix $checkRsix
    
}
elseif ($checkRsix -eq "RainbowSix") {
    Give-Response $checkRsix $checkUbi
    Kill-Rsix $checkRsix
}
else {
    Write-Output "Sending kill resonse anyways...."
    Stop-Process -Name upc -ErrorAction Continue
}