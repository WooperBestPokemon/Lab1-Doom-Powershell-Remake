class monster{

    [string]$name
    [string]$weapon_name
    [int]$hp
    [int]$attack
    [int]$agility

    monster($name, $weapon_name, $hp, $attack, $agility){
        $this.name = $name
        $this.weapon_name = $weapon_name
        $this.hp = $hp
        $this.attack = $attack
        $this.agility = $agility
    }
}