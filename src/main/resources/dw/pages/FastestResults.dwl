var header = [
//		"## Fastest racers",
		"| Rank | Name | Time | Finished |",
		"| ---- | ---- | ---- | -------- |",
	]
	

fun formatResults(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.best.elapsed)s" ++
		" | $(raceResult.best.finish as DateTime as String {format: 'MMMM d HH:mm:ss O'})" ++
		" |"
fun markdown(standings) =
	(header ++ formatResults(standings orderBy $.best.elapsed))
 		joinBy "\n"