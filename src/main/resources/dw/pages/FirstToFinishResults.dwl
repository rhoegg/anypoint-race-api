var header = [
//		"## First finishers",
		"| Rank | Name | Finished | Time | Best Time |",
		"| ---- | ---- | -------- | ---- | --------- |",
	]
	

fun formatResults(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.first.finish as DateTime as String {format: 'MMMM d HH:mm:ss O'})" ++
		" | $(raceResult.first.elapsed)s" ++
		" | $(raceResult.best.elapsed)s" ++ 
		" |"
fun markdown(standings) =
	(header ++ formatResults(standings orderBy $.first.finish))
 		joinBy "\n"