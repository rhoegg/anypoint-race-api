var header = [
//		"## Most Up-To-Date racers",
		"| Rank | Name | Time Taken |",
		"| ---- | ---- | ---------- |",
	]
	

// TODO: update this code to update leaderboards with content.

fun getEasterEggFinishes(standings) = flatten(standings.*races) filter (raceResult) -> (raceResult.laps == 2023)

fun formatResults(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.elapsed)s" ++
		" |"
fun markdown(standings) =
	(header ++ formatResults(getEasterEggFinishes(standings) orderBy (-1 * $.elapsed)))
 		joinBy "\n"
 
 // flatten(standings.*races) filter (races) -> (races.laps == 2023)