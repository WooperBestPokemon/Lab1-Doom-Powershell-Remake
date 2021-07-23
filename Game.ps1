############################################################
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass#
############################################################
Using Module ".\modules\Audio.psm1"
Using Module ".\modules\Player.psm1"
Using Module ".\modules\Graphic.psm1"

#Classes
$audio = New-Object audio
$graphic = New-Object graphic

#THIS IS WHERE THE GAME BEGIN

$graphic.TitleScreen($host)
$audio.play("intro")
Write-Host "The game has been loaded ! (not really, I just wasted your time into hearing the beeps)"
Write-Host "Please press enter to continue.."
Read-Host
Clear-Host

[player]$player = [player]::new($host, $graphic)




