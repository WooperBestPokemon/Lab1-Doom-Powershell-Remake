class graphic{
    [void]TitleScreen($host){
        $this.ChangeColor("red","black",$host)
        Clear-Host

        Write-Host "______ _____  ________  ___"
        Write-Host "|  _  |  _  ||  _  |  |/  |"
        Write-Host "| | | | | | || | | | .  . |"
        Write-Host "| | | | | | || | | | ||/| |"
        Write-Host "| |/ /| |_/ /| |_/ / |  | |"
        Write-Host "|___/ |____/ |____/|_|  |_/"
        Write-Host "Loading... (not really)"
    }
    [void]ClassExplation($host){
        $this.ChangeColor("yellow","black",$host)
        Write-Host "It's time to choose your combat class"
        Write-Host ""
        Write-Host "1. The lucky bastard :" -ForegroundColor Yellow -NoNewline; Write-Host " Your luck is your weapon. (you kinda lack everything else)" -ForegroundColor White;
        Write-Host "2. The Heavy :" -ForegroundColor Yellow -NoNewline; Write-Host " You are fat, so you have more HP. Also you are stronger with your weapons cause reason." -ForegroundColor White;
        Write-Host "3. Ninja :" -ForegroundColor Yellow -NoNewline; Write-Host " You wanna be ninja ( https://www.youtube.com/watch?v=6jDHRW6fngg )" -ForegroundColor White;
        Write-Host "4. The Normies :" -ForegroundColor Yellow -NoNewline; Write-Host " Normal Experience (kinda boring tho)" -ForegroundColor White;
        Write-Host "5? .--SD!?h9bF#!WS/!b"
    }
    [void]BlueScreen($host){
        $this.ChangeColor("White","DarkBlue",$host)
        Write-Host "A problem has been detected and $($env:computername) has been shutdown to prevent damage to your computer."
        Write-Host ""
        Write-Host "A process or thread crucial to system operation has unexpectedly exited or been terminated."
        Write-Host ""
        Write-Host "If this is the first time you've seen this stop error screen,"
        Write-Host "Restart the game and enter a valid input for the classes"
        Write-Host "If this screen appears again, follow these steps"
        Write-Host ""
        Write-Host "Check to make sure any new hardware or software is properly installed. If this is a new installation, ask your hardware or software manufacturer for any Doom uptates you might need."
        Write-Host ""
        Write-Host "If problems continue, disable or remove any newly installed hardware or software. Disable BIOS memory options such as caching or shadowing."
        Write-Host ""
        Write-Host "Technical information:"
        Write-Host ""
        Write-Host "*** STOP: 0X000000F4 (0X0000003,0X83776D40,0X84776EAC,0XB29FB000"
        [console]::beep(3000,4000)
    }
    [void]GameOver($host, $audio){
        $this.ChangeColor("Red","Black",$host)
        
        Write-Host ""
        Write-Host "█░░█ █▀▀█ █░░█   █▀▀█ █▀▀█ █▀▀   █▀▀▄ █▀▀ █▀▀█ █▀▀▄"
        Write-Host "█▄▄█ █░░█ █░░█   █▄▄█ █▄▄▀ █▀▀   █░░█ █▀▀ █▄▄█ █░░█"
        Write-Host "▄▄▄█ ▀▀▀▀ ░▀▀▀   ▀░░▀ ▀░▀▀ ▀▀▀   ▀▀▀░ ▀▀▀ ▀░░▀ ▀▀▀░"
        Write-Host ""
        Write-Host "Tips : Git Gud"

        $audio.play("Game_Over")
        exit
    }
    [void]DodgeVictory($host, $audio){
        $this.ChangeColor("Cyan","Black",$host)
		$this.PrintVictory()
		
        Write-Host "You got the dodge ending ! (THERE IS 3 ENDINGs)"

        $audio.play("Good")
        $audio.play("Megalovania")
        exit
    }
    [void]NormalVictory($host, $audio){
        $this.ChangeColor("Green","Black",$host)
		$this.PrintVictory()
		
        Write-Host "You got the normal ending ! (THERE IS 3 ENDINGs)"

        $audio.play("Good")
        $audio.play("Take_On_Me")
        exit
    }
    [void]LuckyVictory($host, $audio){
        $this.ChangeColor("Yellow","Black",$host)
		$this.PrintVictory()
		
        Write-Host "You got the lucky ending ! (THERE IS 3 ENDINGs)"

        $audio.play("Good")
        $audio.play("Baby_Shark")
        exit
    }
	[void]PrintVictory()
	{
		Write-Host ""
        Write-Host "██╗   ██╗██╗ ██████╗████████╗ ██████╗ ██████╗ ██╗   ██╗    ██╗"
        Write-Host "██║   ██║██║██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██║"
        Write-Host "██║   ██║██║██║        ██║   ██║   ██║██████╔╝ ╚████╔╝     ██║"
        Write-Host "╚██╗ ██╔╝██║██║        ██║   ██║   ██║██╔══██╗  ╚██╔╝      ╚═╝"
        Write-Host " ╚████╔╝ ██║╚██████╗   ██║   ╚██████╔╝██║  ██║   ██║       ██╗"
        Write-Host "  ╚═══╝  ╚═╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝"
        Write-Host ""
	}
    [void]ChangeColor($foreground, $background, $host){
        $console = $host.ui.rawui
        $console.backgroundcolor = $background
        $console.foregroundcolor = $foreground
        Clear-Host
    }
}