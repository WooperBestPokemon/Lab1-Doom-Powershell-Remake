class audio
{
    [void]play($song_name)
    {
        Write-Host "Now playing : $song_name"
        
        $notes = Import-Csv .\Audio\$song_name.csv -Delimiter ";" -Header 'frequency', 'duration'

        foreach($note in $notes){
            [console]::beep($note.frequency,$note.duration)
        }
    }
}