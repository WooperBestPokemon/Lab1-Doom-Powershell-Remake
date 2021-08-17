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
$audio.play("intro")
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

    Write-Host "The SMG fires 5 bullets for an average of 50 dmg p/t"
	Write-Host ""
}
else
{
    Write-Host "After some investigation, you find out that this person was a policeman."
    Write-Host ""
    Write-Host "You found a energy pistol !"

    $audio.play("item")
}

Write-Host "The energy pistol can only be fire once per turn (it needs to recharge) and deal a fixed 30 dmg."
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
        Write-Host "As you walk, you find a shotgun laying on the ground.. You take it and add it to your inventory"
        $inventory.AddWeapon("Shotgun")
        $audio.play("item")
        Write-Host "The shotgun shoots 2 bullets per turn. The damage output varie from 20 to 90 damages."
        Write-Host ""
        Write-Host "You reach the other end of the hall without a problem."
    }
    else
    {
        Write-Host "You keep walking until step on something and fall on your ass !"
        [console]::beep(400,300)
        Write-Host "Ouch ! you lose 5 HP :c"
        $player.hp -= 5
        Write-Host ""
        Write-Host "You look at the thing you stepped on and notice it has the shape of a gun..."
        Write-Host "You grab it... Shotgun acquired !"
        $inventory.AddWeapon("Shotgun")
        $audio.play("item")
        Write-Host "The shotgun shoots 2 bullets per turn. The damage output varie from 20 to 90 damages."
        Write-Host ""
        Write-Host "You walk towars the end of the hall with a small pain on your butt tho.."
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
    Write-Host ""
    Write-Host "You proceed to the next room..."
    Read-Host
    $graphic.ChangeColor("DarkRed", "Gray")
    Write-Host "You arrive in a small room. There is two doors."
    Write-Host ""
    Write-Host "The first door as a sign saying 'Enter and Die'"
    Write-Host "The second door looks normal"
    Write-Host ""
    if($utility.PromptChoice("Which door do you want to choose ?", @("The door with the deadly sign","The normal door")) -eq 2)
    {
        Write-Host "You decide to walk toward the normal door..."
        Write-Host ""
        Write-Host "As you enter, you step into a pressure plate. The ground disappears and you fall into a pool lava..."
        Write-Host ""
        Write-Host "Press a key to continue..."
        Read-Host
        $graphic.GameOver($host, $audio)
    }
    Write-Host "You enter inside the menacing room... but nothing happen... probably a troll or something."
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    Clear-Host
    Write-Host "You arrive in a small room... and at the middle of the room, there is an IMP that appears from nowhere !"
    Write-Host ""
    if($utility.ChanceCheck(1, 11, $player.luck, 15))
    {
        Write-Host "As it starts attacking you with its fireballs, an earthquake appears and a piece of rock in falling from the roof, landing on its head"
        Write-Host ""
        Write-Host "Still alive but badly damaged, it attacks you !!"
        Write-Host ""
        Write-Host "============================="
        Write-Host " Fight Start !! Imp"
        Write-Host "============================="
        Write-Host ""
        Write-Host "Press Enter to continue..."
        Read-Host
        [monster]$imp = [monster]::new("Imp", "fireballs", 20, 50, 50)
        $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $imp)
    }
    else
    {
        Write-Host "============================="
        Write-Host " Fight Start !! Imp"
        Write-Host "============================="
        Write-Host ""
        Write-Host "Press Enter to continue..."
        Read-Host
        [monster]$imp = [monster]::new("Imp", "fireballs", 100, 50, 50)
        $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $imp)
    }
    Write-Host ""
    Write-Host "On the IMP body, you find a medkit ! You heal yourself for 100 HP !"
    $player.hp += 100
    Write-Host ""
    Write-Host "You then proceed to the final room..."
}

#Path of the Light
else{
    $graphic.ChangeColor("DarkRed","White",$host)
}

Write-Host ""
Write-Host "Press a key to continue..."
Read-Host
$graphic.ChangeColor("DarkRed","Black",$host)
#Final Room

Write-Host "On the door of the final room, there is a bloody sign.."
Write-Host ""
Write-Host "█▀▀▄ █▀▀█     █▀▀▄ █▀▀█ ▀▀█▀▀     █▀▀ █▀▀▄ ▀▀█▀▀ █▀▀ █▀▀█"
Write-Host "█░░█ █░░█     █░░█ █░░█ ░░█░░     █▀▀ █░░█ ░░█░░ █▀▀ █▄▄▀"
Write-Host "▀▀▀░ ▀▀▀▀     ▀░░▀ ▀▀▀▀ ░░▀░░     ▀▀▀ ▀░░▀ ░░▀░░ ▀▀▀ ▀░▀▀"
Write-Host ""
Write-Host "You decide to kick the door open, ready for a fight !"
Write-Host ""
Write-Host "Press a key to continue..."
Read-Host
Clear-Host

#The MasterBall will be added to the player's inventory without its consent.
if($utility.ChanceCheck(1, 11, $player.luck, 12))
{ $inventory.AddWeapon("Master_Ball") }

