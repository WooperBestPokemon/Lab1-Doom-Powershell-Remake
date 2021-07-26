class player{

    [string]$name
    [int]$hp
    [int]$luck
    [int]$strengh
    [int]$agility

    player($host, $graphic){
        $this.CharacterCreation($host, $graphic)
    }

    [void]SetStat($class, $host, $graphic){
		switch($class)
		{
            1 #Lucky_Bastard
            {
                $this.hp = 80
                $this.luck = 9
                $this.strengh = 3
                $this.agility = 3
            }
            2 #Heavy
            {
                $this.hp = 150
                $this.luck = 3
                $this.strengh = 9
                $this.agility = 3
            }
            3 #Ninja
            {
                $this.hp = 50
                $this.luck = 3
                $this.strengh = 3
                $this.agility = 9
            }
            4 #Normal
            {
                $this.hp = 100
                $this.luck = 5
                $this.strengh = 5
                $this.agility = 5
            }
            5 #Blue_Screen
            {
                $graphic.BlueScreen($host)
                exit
            }
		}
    }
    [void]CharacterCreation($host, $graphic){
        while($true){
            Write-Host "Please input your name.."
            $tempName = Read-Host
            Write-Host ""
			
            if($tempName -ne "DoomGuy")
            { Write-Host "$tempName, you are sure you want this game ? (Like for real ? I won't judge...) (y/n)" }
            else
            {
              Write-Host "Wow, that is a good name ! Wanna keep it ? ($tempName) (y/n)"
            }
            $choice = Read-Host

            if($choice -eq "y" -or $choice -eq "Y")
            { 
                $this.name = $tempName
                Clear-Host
                break 
            }
            Clear-Host
        }

        $GoodChoice = $true
        do
        {
            if($GoodChoice = $false)
            { Write-Host "Please Select a good value. "}

            $graphic.ClassExplation($host)
            Write-Host ""
            Write-Host "Please make your choice"
            $choice = Read-Host

            if($choice -gt 0 -and $choice -lt 6){
                $this.SetStat($choice, $host, $graphic)
            }
            else
            {$GoodChoice = $false}
        }
        while($GoodChoice)
		
		Clear-Host
		Write-Host "Alright $($this.name), your adventure is about to begin !"
		Write-Host "Press Enter to finally start the game..."
		Read-Host
		Clear-Host
    }
}