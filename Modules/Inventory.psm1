class inventory{
	
	#Weapons
	[bool]$Pistol = $true
    [bool]$SMG = $false
    [bool]$Shotgun = $false
    [bool]$Bazooka = $false
    [bool]$Master_Ball = $false
	#Ammo
	[int]$Pistol_Ammo = 0
	[int]$SMG_Ammo = 0
	[int]$Shotgun_Ammo = 0
	[int]$Bazooka_Ammo = 0
	
	
	[void]AddWeapon($weapon_name){
		switch($weapon_name)
		{
            "SMG"
            {
                $this.SMG = $true
				$this.SMG_Ammo += 30
            }
            "Shotgun"
            {
                $this.Shotgun = $true
                $this.Shotgun_Ammo += 4
            }
            "Bazooka"
            {
				$this.Bazooka = $true
                $this.Bazooka_Ammo += 1
            }
            "Master_Ball"
            {
                $this.Master_Ball = $true
            }
		}
	}
	[void]AddAmmo($weapon_name, $nbAmmo){
		switch($weapon_name)
		{
            "SMG"
            {
                $this.SMG_Ammo += $nbAmmo
            }
            "Shotgun"
            {
                $this.Shotgun_Ammo += $nbAmmo
            }
            "Bazooka"
            {
				$this.Bazooka_Ammo += $nbAmmo
            }
		}
	}
    [array]GetWeapons(){
        [System.Collections.ArrayList]$weapons = @()
        
        $weapons.Add("Pistol")

        if($this.SMG){
            $weapons.Add("SMG")
        }
        if($this.Shotgun){
            $weapons.Add("Shotgun")
        }
        if($this.Bazooka){
            $weapons.Add("Bazooka")
        }
        if($this.Master_Ball){
            $weapons.Add("Master_Ball")
        }

        return $weapons
    }
}