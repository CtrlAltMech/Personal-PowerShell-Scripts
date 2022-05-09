
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

# Issues the response as well as the process kill...for now
function Give-Response  ($r6version){
    Write-Output "R6 is running $r6version"
    Write-Output "Killing Rainbow Six Siege and all things Ubisoft..."
    #Stop-Process -Name $r6version
    #Stop-Process -Name upc
    Write-Output "Done"
}

$checkRsix = Check-Rsix
$checkUbi = Check-Ubi

Write-Output "Looks like checkRsix is returning $checkRsix and checkUbi is returning $checkUbi"

if (($checkUbi -eq $false) -and ($checkRsix -eq $false)) {
    Write-Output "It does not appear that Rainbow Six Siege is running or any Ubisoft garbage to support it."
    Read-Host "Press Enter to exit the script"
}
elseif ($checkRsix -eq "RainbowSix_Vulkan") {
    Give-Response $checkRsix
}
elseif ($checkRsix -eq "rb6") {
    Write-Output "R6 is running openGL"
}
else {
    Write-Output "RB6 is not running"
}

#$isRunning = Check-Rsix

#Write-Output "Rainbow Six is not running..."
#Write-Output "Killing all things Ubisoft..."

#Write-Output $isRunning



#Stop-Process -Name RainbowSix_Vulkan
#Stop-Process -Name upc