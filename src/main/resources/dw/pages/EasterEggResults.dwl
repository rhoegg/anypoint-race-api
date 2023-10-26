var header = [
//		"## Most Up-To-Date racers",
		"| Rank | Name | Time Taken |",
		"| ---- | ---- | ---------- |",
	]
	


fun getEasterEggFinishes(standings) = flatten(standings.*races) filter (raceResult) -> (!isEmpty(raceResult.laps) and raceResult.laps >= 2023)

fun formatResults(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.elapsed)s" ++
		" |"
fun markdown(standings) =
	(header ++ formatResults(getEasterEggFinishes(standings) orderBy ($.elapsed)))
 		joinBy "\n"
 
 // flatten(standings.*races) filter (races) -> (races.laps == 2023)