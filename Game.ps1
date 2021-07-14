Using Module ".\modules\Audio.psm1"

#Classes
$audio = New-Object audio

#Global Variables
#$path = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)


$audio.play("Intro")