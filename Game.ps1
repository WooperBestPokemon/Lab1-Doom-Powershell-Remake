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

if($utility.ChanceCheck(1, 11, $player.luck, 12)){
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
if($utility.PromptChoice("Where do you want to proceed ?", @("Dark Hall", "Illuminated Room")) -eq 1){
    $graphic.ChangeColor("White","Black",$host)
    
    Write-Host "As you step inside the dark hall, the door being you disappears, like if it never existed in the first place."
    Write-Host ""
    Write-Host "Your eyes slowly adapt to the darkness as you make your way toward the other side of the hall."
    Write-Host ""

    if($utility.ChanceCheck(1, 11, $player.agility, 8)){
        Write-Host "As you walk, you find a shotgun (4 bullets) laying on the ground.. You take it and add it to your inventory"
        $inventory.AddWeapon("Shotgun")
        $audio.play("secret")
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
    $graphic.ChangeColor("DarkRed", "Gray", $host)
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
    Write-Host "The room looks like some kind of scientist laboratory"
    Write-Host ""
    Write-Host "At the end of it, a posseded scientist is slowly turning around, noticing you"
    Write-Host ""
    Write-Host "You sigh and prepare for a fight.."
    Write-Host ""
    Write-Host "============================="
    Write-Host " Fight Start !! Posseded"
    Write-Host "============================="
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    [monster]$scientist = [monster]::new("Scientist", "potions", 20, 5, 5)
    $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $scientist)
    Clear-Host
    Write-Host "Well, that was easy... but too easy...."
    Write-Host ""
    Write-Host "In the room, there is a terminal asking for an answer."
    Write-Host ""
    Write-Host "'What is the wecommended amount of dedotated wam I should have for my minecraft survr ?'"
    $terminal = $utility.PromptChoice("Input >", @("< Blank >", "4 Gb is enough for a 2-3 players vanilla server, but if we are talking about a 25-50 servers, 32 Gb [...]", "42"))
    switch($terminal)
    {
        1
        {
            #Damage
            Write-Host "You press 'enter' without writing anything..."
            Write-Host ""
            Write-Host "The computer keep trying to find a logic of your answer and quicky overload, exploding."
            Write-Host ""
            Write-Host "BOOMM ! 50 HP of damage :c"
            $player.hp -= 50
            Write-Host ""
            Write-Host "Press Enter to continue..."
            Read-Host
        }
        2
        {
            #Fight
            Write-Host "You input a complete answer.. You keep typing and typing, writting about every case scenario..."
            Write-Host ""
            Write-Host "After a good hour of two, you finally press 'enter'. Nothing happen... You stretch and look around you... Zombies everyhere !"
            Write-Host ""
            Write-Host "The sound of your fight earlier must have attracted a horde of posseded..."
            Write-Host ""
            Write-Host "You can at least count 10 of them."
            Write-Host ""
            Write-Host "================================"
            Write-Host " Fight Start !! Possededs horde"
            Write-Host "================================"
            Write-Host ""
            Write-Host "Press Enter to continue..."
            Read-Host
            [monster]$horde = [monster]::new("Possededs", "arms", 200, 25, 50)
            $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $horde)
            Clear-Host
        }
        3
        {
            #Skip
            Write-Host "The computer make a beep saying it was the right answer ! (Good Job)"
            [console]::beep(600,400)
            Write-Host ""
            Write-Host "Press Enter to continue..."
            Read-Host
        }
    }
    $graphic.ChangeColor("White","Black",$host)
    Write-Host "A metalic door open behind you. You proceed inside, leaving the laboratory behind"
    Write-Host ""
    Write-Host "Inside, it looks like some kind of testing area. Few rotten human corpses are laying on the floor"
    Write-Host ""
    if($utility.ChanceCheck(1, 11, $player.chance, 14)){
        Write-Host "You notice a locked locker. You try to mess around it and since it was pretty old, it broke into your hand."
        Write-Host ""
        Write-Host "Inside it, you find a Shotgun ! (+4 bullets)"
        Write-Host ""
        $inventory.AddWeapon("Shotgun")
        $audio.play("item")
        Write-Host "The shotgun shoots 2 bullets per turn. The damage output varie from 20 to 90 damages."
        Write-Host ""
    }
    Write-Host "You notice that the exit is locked behind a glass door controlled by another terminal..."
    Write-Host ""
    Write-Host "But behind this door, a failed experiment is roaming around..."
    Write-Host ""
    Write-Host "You approche the terminal and press 'Open Door'"
    Write-Host ""
    Write-Host "The door slowly opens.."
    Write-Host ""
    Write-Host "==================================="
    Write-Host " Fight Start !! Failed Experiment."
    Write-Host "==================================="
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    [monster]$horde = [monster]::new("Failed Experiment", "spikes", 100, 40, 60)
    $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $horde)
    Clear-Host
    Write-Host "Inside one of the locker next to the final door, you find a medkit ! You heal yourself for 100 HP !"
    $player.hp += 100
    Write-Host ""
    Write-Host "You then proceed to the final room..."
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

#The MasterBall will be added to the player's inventory without its consent (luck ending check).
if($player.luck -ge 9)
{ $inventory.AddWeapon("Master_Ball") }

Write-Host "You feel a small earthquake as you enter the room... some rocks fall behind you, blocking your exit."
Write-Host ""
Write-Host "There is only one way out, fowards... but, in the middle of the room, a pinky is minding his own business..."
Write-Host ""
Write-Host "You try to sneak around the demon using the piles of death bodies.."
Write-Host ""
Write-Host "Press Enter to continue..."
Read-Host
Clear-Host
#Agility Ending
if($player.agility -ge 9)
{
    Write-Host "You think 'Sneaking is for bitches', so you charge at the pinky full speed !"
    Write-Host ""
    Write-Host "Without being noticed, you climb into its back and grabs your two knifes, stabbing both of the pinky's eye at the same time."
    Write-Host ""
    Write-Host "The creature scream in pain and attack you blindly. You let out a small laugh and throw your knifes into its mouth and drop kick its jaw"
    Write-Host ""
    Write-Host "You slowly walk away from the blind pinky, letting it suffers until it died by itself."
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    $graphic.DodgeVictory($host, $audio)
}
#Lucky ending / Normal Ending
else
{
    Write-Host "While you try to sneak past the Pinky, from one of the pile of death bodies, an arm grab your foot"
    Write-Host ""
    if($player.strengh -ge 9)
    {
        Write-Host "You punch the arm, breaking the zombie's arm. The sound is loud enough to be heard by the pinky..."
        Write-Host ""
        Write-Host "The pile of corpes break down. Between the bodies, you find a bazooka (1 rocket) !"
        $inventory.AddWeapon("Bazooka")
        $audio.play("secret")
        $audio.play("item")

        Write-Host "The Bazooka fires 1 rocket for an average of 120 dmg p/t"
	    Write-Host ""
    }
    else
    {
        Write-Host "You grab your pistol and shoot the zombie's arm. The sound is loud enough to be heard by the pinky..."
    }
    Write-Host ""
    Write-Host "Before you know it, a pinky is charging you at full speed !"
    Write-Host ""
    Write-Host "============================="
    Write-Host " Fight Start !! Pinky"
    Write-Host "============================="
    Write-Host ""
    Write-Host "Press Enter to continue..."
    Read-Host
    [monster]$pinky = [monster]::new("Pinky", "horns", 200, 45, 500)
    $fight.start_fight($inventory, $player, $graphic, $utility, $audio, $host, $pinky)

    $graphic.NormalVictory($host, $audio)
}