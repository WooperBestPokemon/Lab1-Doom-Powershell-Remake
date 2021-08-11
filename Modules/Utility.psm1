class utility{
    [bool]ChanceCheck($min, $max, $player_luck, $target){
        $randomNumber = Get-Random -Minimum $min -Maximum $max

        if(($randomNumber + $player_luck) -ge $target)
        { return $true }
        else
        { return $false }
    }
	[int]PromptChoice($choice_question, $choice_array){
		$choice = 0
		
        $Bad_Choice = $false
		while($true)
        {
		
            if($Bad_Choice)
            { 
                Write-Host "Please Select a good value." 
                Write-Host ""
            }

            Write-Host $choice_question
            Write-Host ""

            for ($i=0; $i -le ($choice_array.count - 1); $i++) {
                Write-Host "$($i + 1). $($choice_array[$i])"
            }

            $choice = Read-Host

            Clear-Host

            #If the choice is valid
            if($choice -gt 0 -and $choice -le $choice_array.count)
            { break }
            else
            { $Bad_Choice = $true }
		}

		return $choice
	}
}