class fight{
    [void]start_fight($inventory, $player, $graphic, $utility, $audio, $host, $monster)
    {
        $graphic.ChangeColor("Red","Black",$host)
        $console = $host.ui.rawui

        [System.Collections.ArrayList]$weapons = $inventory.GetWeapons()
        $weapons.Add("Escape")

        $kill = $false
        $escape = $false

        if($weapons.Contains("Master_Ball")){
            #Player has masterball, play pkm music
            $graphic.PokemonAppears($host, $audio)
            $graphic.ChangeColor("Red","Black",$host)
        }

        while($true)
        {
            Write-Host "========================="
            Write-Host " $($monster.name)"
            Write-Host "========================="

            $console.foregroundcolor = "White"
            Write-Host "HP : $($monster.hp)"
            $console.foregroundcolor = "Red"
            Write-Host ""
            Write-Host ""
            Write-Host "========================="
            Write-Host " $($player.name)"
            Write-Host "========================="
            $console.foregroundcolor = "White"
            Write-Host "HP : $($player.hp)"
            $console.foregroundcolor = "Red"

            Write-Host ""
            $weapon_choice = $utility.PromptChoice("What do you want to use ?", $weapons)
            
            #The player always attack first cause I'm lazy

            #Escape Option
            if($weapon_choice -eq $weapons.count)
            {
                Write-Host "You decide to run away from the $($monster.name)..."
                Write-Host ""

                #Player is faster than the monster (high chance)
                if(($player.agility * 10) -ge $monster.agility)
                {
                    Write-Host "Your are moving faster than the enemy. You try to make your way past the ennemy."

                    $randomNumber = Get-Random -Minimum 1 -Maximum 11
                    if($randomNumber -lt $player.agility)
                    {
                        $escape = $true
                        Write-Host ""
                        Write-Host "You manage to escape the enemy !" -ForegroundColor Green
                    }
                    else
                    {
                        $random = Get-Random -Minimum 1 -Maximum 3
                        switch($random)
                        {
                            1
                            {
                                Write-Host "The ennemy manage to stop you tackling you on the ground. You lose 10 HP !"
                                $this.HurtPlayer(10, $player)
                                $this.DeathCheck($player.hp, $graphic, $audio, $host)
                            }
                            2
                            {
                                Write-Host "While running away, you stumble into something... The ennemy catch up to you. You lose 5 HP !"
                                $this.HurtPlayer(5, $player)
                                $this.DeathCheck($player.hp, $graphic, $audio, $host)
                            }
                        }
                    }
                }
                #Player is slower than the monster (low chance)
                else
                {
                    Write-Host "You are moving slower than the ennemy..."
                    #10 % chance
                    $randomNumber = Get-Random -Minimum 1 -Maximum 11
                    if($randomNumber -eq 1)
                    {
                        $escape = $true
                        Write-Host ""
                        Write-Host "You manage to escape the enemy somehow..?"  -ForegroundColor Green
                    }
                    else
                    {
                        Write-Host "Due to your bad agility, the $($monster.name) stop you with ease and punch you in the face !"
                        Write-Host "You lose 20 HP !"
                        $this.HurtPlayer(20, $player)
                        $this.DeathCheck($player.hp, $graphic, $audio, $host)
                    }
                }
            }
            #Weapon
            else{
                switch($weapons[$weapon_choice - 1])
                {
                    "Pistol"
                    {
                        Write-Host "You decide to shoot with your pistol !"
                        Write-Host ""
                        Write-Host "You fire at the $($monster.name) and deal 30 damages !"
                        $monster.hp -= 30
                        if($monster.hp -le 0)
                        { $kill = $true }
                    
                    }
                    "SMG"
                    {
                        Write-Host "You decide to shoot with your SMG !"
                        Write-Host ""
                        if($inventory.SMG_Ammo -gt 0)
                        {
                            $damage = 5 * (Get-Random -Minimum 6 -Maximum 13)
                            Write-Host "You fire 5 bullets at the $($monster.name) for a total of $damage damages !"
                            $inventory.SMG_Ammo -= 5
                            $monster.hp -= $damage
                            if($monster.hp -le 0)
                            { $kill = $true }
                    
                        }
                        else
                        {
                            Write-Host "Click...Click... Hmhm... No bullet... what a waste of turn !"
                        }
                    }
                    "Shotgun"
                    {
                        Write-Host "You decide to shoot with your Shotgun !"
                        Write-Host ""
                        if($inventory.Shotgun_Ammo -gt 0)
                        {
                            $damage = Get-Random -Minimum 20 -Maximum 90
                            Write-Host "You fire at the $($monster.name) for a total of $damage damages !"
                            $inventory.Shotgun_Ammo -= 2
                            $monster.hp -= $damage
                            if($monster.hp -le 0)
                            { $kill = $true }
                    
                        }
                        else
                        {
                            Write-Host "Click...Click... Hmhm... No bullet... what a waste of turn !"
                        }
                    }
                    "Bazooka"
                    {
                        Write-Host "You decide to shoot with your Bazooka !"
                        Write-Host ""
                        if($inventory.Bazooka_Ammo -gt 0)
                        {
                            $damage = Get-Random -Minimum 90 -Maximum 150
                            Write-Host "You launch a rocket at the $($monster.name), dealing $damage damages !"
                            $inventory.Bazooka_Ammo -= 1
                            $monster.hp -= $damage
                            if($monster.hp -le 0)
                            { $kill = $true }
                        }
                        else
                        {
                            Write-Host "Click...Click... Hmhm... No bullet... what a waste of turn !"
                        }
                    }
                    "BFG"
                    {
                        Write-Host "You decide to shoot with the BFG !"
                        Write-Host ""
                        if($inventory.BFG_Ammo -gt 0)
                        {
                            Write-Host "The weapon starts glowing as it charge before shooting a massive energy ball to the $($monster.name)"
                            Write-Host ""
                            Write-Host "The demon explode into a very gory way !"
                            $inventory.BFG_Ammo -= 1
                            $kill = $true
                        }
                        else
                        {
                            Write-Host "Click...Click... Hmhm... No bullet... what a waste of turn !"
                        }
                    }
                    "Master_Ball"
                    {
                        #Lucky Ending
                        $graphic.LuckyVictory($host ,$audio)
                    }
                }
            }
            Write-Host ""
            #Winning the fight.
            if($escape -or $kill)
            {
                
                if($escape)
                {
                    Write-Host "You walks toward the next room..."
                }
                else
                {
                    Write-Host "The $($monster.name) drop on the ground, dead."
                    Write-Host ""
                    #Default Kill Reward
                    $randomNumber = Get-Random -Minimum 1 -Maximum 4
                    switch($randomNumber)
                    {
                        1
                        {
                            Write-Host "You find a small chunk of ammos on the $($monster.name)'s body."
                            Write-Host ""
                            Write-Host "+5 SMG Ammo" -ForegroundColor Yellow
                            $inventory.SMG_Ammo += 5
                        }
                        2
                        {
                            Write-Host "You find some bandages on the $($monster.name)'s body."
                            Write-Host ""
                            Write-Host "Your HP increase by 20 hp" -ForegroundColor Yellow
                            $player.hp += 20
                        }
                        3
                        {
                            Write-Host "You find a a good chunk of ammos and few bandages on the $($monster.name)'s body."
                            Write-Host ""
                            Write-Host "+15 SMG Ammo" -ForegroundColor Yellow
                            Write-Host "Your HP increase by 20 hp" -ForegroundColor Yellow
                            $inventory.SMG_Ammo += 15
                            player.hp += 20
                        }
                    }
                }
                Write-Host "Press a key to continue..."
                Read-Host
                break
            }
            #Monster's turn
            Write-Host ""
            Write-Host "The $($monster.name), still alive, attack you with its $($monster.weapon_name), dealing you $($monster.attack) damages ;-;"
            $this.HurtPlayer($monster.attack, $player)
            $this.DeathCheck($player.hp, $graphic, $audio, $host)
            Write-Host "Press Enter for the next turn..."
            Read-Host
            Clear-Host
        }
    }
    [void]DeathCheck($HP, $graphic, $audio, $host){
        #GameOver
        if($HP -le 0)
        { 
            Write-Host ""
            Write-Host "Press a key to continue..."
            Read-Host
            $graphic.GameOver($host, $audio) 
        }
    }
    [void]HurtPlayer($HP, $player){
        $player.hp -= $HP
    }
}