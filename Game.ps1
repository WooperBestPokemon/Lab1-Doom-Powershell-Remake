############################################################
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass#
############################################################
Using Module ".\modules\Audio.psm1"
Using Module ".\modules\Player.psm1"
Using Module ".\modules\Graphic.psm1"
Using Module ".\modules\Utility.psm1"
Using Module ".\modules\Inventory.psm1"
Using Module ".\modules\Fight.psm1"
Using Module ".\modules\Monster.psm1"

#Classes
$audio = New-Object audio
$graphic = New-Object graphic
$utility = New-Object utility
$inventory = New-Object inventory
$fight = New-Object fight

#THIS IS WHERE THE GAME BEGIN


$graphic.TitleScreen($host)
#$audio.play("intro")
Write-Host "The game has been loaded ! (not really, I just wasted your time into hearing the beeps)"
Write-Host "Please press enter to continue.."
Read-Host
Clear-Host

#CHARACTER CREATION
[player]$player = [player]::new($host, $graphic) # ex : $player.name

$graphic.ChangeColor("White","DarkRed",$host)

Write-Host "You wake up in some kind of tomb. Around you, there is blood everywhere."
Write-Host ""

Write-Host "Laying next to the tomb, there is a dead body. You search the body..."

if($utility.ChanceCheck(1, 11, $player.luck, 9)){
    Write-Host "After some investigation, you find out that this person was an army trooper."
    Write-Host ""
    Write-Host "You found a SMG (with 30 bullets) and a energy pistol !"
    
    $inventory.AddWeapon("SMG")
    $audio.play("item")

    Write-Host "The SMG fires 5 bullets for a total of 50 dmg p/t"
	Write-Host ""
}
else
{
    Write-Host "After some investigation, you find out that this person was a policeman."
    Write-Host ""
    Write-Host "You found a energy pistol !"

    $audio.play("item")
}

Write-Host "The energy pistol can only be fire once per turn (it needs to recharge) and deal 30 dmg."
Write-Host ""

Write-Host "You leave the dead body and proceed to the next room..."
Write-Host "Press Enter to continue..."
Read-Host
Clear-Host

Write-Host "You enter inside the room. It's the same size as a classroom."
Write-Host "There are two open door, One that leads to a dark hall and one that leads to an illuminated Room."

if($utility.ChanceCheck(1, 11, $player.luck, 13)){

    Write-Host ""
    Write-Host "You notice one of the floor tile is removable. You open it and see a cache full of ammos !"
    $audio.play("secret")
    Write-Host ""
    Write-Host "You found some ammos ! (SMG and Shotgun)"
    
    $inventory.AddAmmo("SMG", 15)
    $inventory.AddAmmo("Shotgun", 4)
    $audio.play("item")
}
#Path of the Darkness
if($utility.PromptChoice("Where do you want to proceed ?", @("Dark Hall", "Illuminated Room"))){
    $graphic.ChangeColor("White","Black",$host)
    
    Write-Host "As you step inside the dark hall, the door being you disappears, like if it never existed in the first place."
    Write-Host ""
    Write-Host "Your eyes slowly adapt to the darkness as you make your way toward the other side of the hall."
    Write-Host ""

    if($utility.ChanceCheck(1, 11, $player.agility, 8)){
        Write-Host "You reach the other end of the hall without a problem."
    }
    else
    {
        Write-Host "You keep walking until step on a broom and fall on your ass !"
        [console]::beep(400,300)
        Write-Host "Ouch ! you lose 5 HP :c"
        $player.hp -= 5

        Write-Host "You walk towars the end of the hall with a small pain on your butt.."
    }
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    $graphic.ChangeColor("White","DarkGray",$host)

    Write-Host "As you enter into the next room, two rockets fly towards you. You barelly manage to dodge them as they explode on a wall behind you."
    Write-Host ""
    Write-Host "The demon in front of you is a Revenant..."
    Write-Host ""
    Write-Host "============================="
    Write-Host " Fight Start !! Revenant"
    Write-Host "============================="
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    [monster]$revenant = [monster]::new("Revenant", "rockets", 60, 50, 80)
    $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $revenant)
}
#Path of the Light
else{
    $graphic.ChangeColor("DarkRed","White",$host)
}