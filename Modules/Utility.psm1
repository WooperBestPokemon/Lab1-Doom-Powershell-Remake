class utility{
    [bool]ChanceCheck($min, $max, $player_luck, $target){
        $randomNumber = Get-Random -Minimum $min -Maximum $max

        if(($randomNumber + $player_luck) -ge $target)
        { return $true }
        else
        { return $false }
    }
}