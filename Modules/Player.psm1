class player{

    [string]$name
    [int]$hp
    [int]$luck
    [int]$strengh
    [int]$agility

    player($name){
        this.$name = $name
    }

    [void]SetStat($class){
		switch($class)
		{
            Lucky_Bastard
            {
                this.$hp = 80
                this.$luck = 9
                this.$strengh = 3
                this.$agility = 3
            }
            Heavy
            {
                this.$hp = 150
                this.$luck = 3
                this.$strengh = 9
                this.$agility = 3
            }
            Matrix_Neo
            {
                this.$hp = 50
                this.$luck = 3
                this.$strengh = 3
                this.$agility = 9
            }
            Normal
            {
                this.$hp = 100
                this.$luck = 5
                this.$strengh = 5
                this.$agility = 5
            }
            Blue_Screen
            {

            }
		}
    }
}