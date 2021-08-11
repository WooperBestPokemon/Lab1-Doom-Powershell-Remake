class fight{
    [void]start_fight($inventory, $player, $graphic, $utility, $audio, $host, $monster)
    {
        $graphic.ChangeColor("Red","Black",$host)
        $console = $host.ui.rawui

        $weapons = $inventory.GetWeapons
        $weapons.add("Escape")

        $kill = $false
        $escape = $false

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
            if($weapon_choice -eq ($weapon_choice.count - 1))
            {
                Write-Host "You decide to run away from the $($monster.name)..."

                #Player is faster than the monster (high chance)
                if(($player.agility * 10) -ge $monster.agility)
                {
                    Write-Host "Your are moving faster than the enemy. You try to make your way past the ennemy."

                    $randomNumber = Get-Random -Minimum 1 -Maximum 11
                    if($randomNumber -lt $player.agility)
                    {
                        $escape = $true
                        Write-Host "You manage to escape the enemy !"
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
                }
            }
            #Weapon
            else{
            }

            #Winning the fight.
            if($escape -or $kill){
                
                if($escape)
                {

                }
                else
                {

                }

                break
            }
        }
    }
    [void]DeathCheck($HP, $graphic, $audio, $host){
        #GameOver
        if($HP -le 0)
        { $graphic.GameOver($host, $audio) }
    }
    [void]HurtPlayer($HP, $player){
        $player.hp -= $HP
    }
}