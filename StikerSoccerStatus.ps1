#Install-Module -Name PSParseHTML	


#get the webpage
$html = (Invoke-WebRequest -Uri "https://www.soccerinorlando.com/wed-4v4-schedule-results").content

$schedule = ConvertFrom-HtmlTable -Content $html

#$schedule[0] | Format-Table -AutoSize

#loop through each game in the schedule
foreach ($game in $schedule[0]){

    if ($game -match 'wk'){
        $week = $game.Time
    }
    if ($game -match 'Plan b'){

        if($game.'Team 1' -notmatch 'plan B'){
            $opponent = $game.'Team 1'
        }
        else{
            $opponent = $game.'Team 2'
        }

        $week + " " + $game.Time + ' Field ' + $game.Field + ' vs. ' + $opponent
    }
}