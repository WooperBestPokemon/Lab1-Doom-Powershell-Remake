class audio{
    [void]play($song_name)
    {
        Write-Host "Now playing : $song_name"
        
        $notes = Import-Csv .\Audio\$song_name.beep -Delimiter ";" -Header 'frequency', 'duration'

        foreach($note in $notes){
            #10 = sleep
            if($note.frequency -eq 10)
            { Start-Sleep -Milliseconds $note.duration }
            else
            { [console]::beep($note.frequency,$note.duration) }
        }
    }
}