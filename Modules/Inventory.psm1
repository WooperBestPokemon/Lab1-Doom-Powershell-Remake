class inventory{
	
	#Weapons
	[bool]$Pistol = $true
    [bool]$SMG = $false
    [bool]$Shotgun = $false
    [bool]$Bazooka = $false
	[bool]$BFG = $false
    [bool]$Master_Ball = $false
	#Ammo
	[int]$Pistol_Ammo = 0
	[int]$SMG_Ammo = 0
	[int]$Shotgun_Ammo = 0
	[int]$Bazooka_Ammo = 0
	[int]$BFG_Ammo = 0
	
	
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
            }
            "Bazooka"
            {
				$this.Bazooka = $true
            }
            "BFG"
            {
                $this.BFG = $true
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
            "BFG"
            {
                $this.BFG_Ammo += $nbAmmo
            }
		}
	}
}