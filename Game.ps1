############################################################
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass#
############################################################
Using Module ".\modules\Audio.psm1"
Using Module ".\modules\Player.psm1"
Using Module ".\modules\Graphic.psm1"

#Classes
$audio = New-Object audio



$audio.play("Take_On_Me")