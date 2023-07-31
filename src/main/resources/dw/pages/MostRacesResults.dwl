var header = [
//		"## Most Tenacious racers",
		"| Rank | Name | Races | First | Last | Average Time |",
		"| ---- | ---- | ----- | ----- | ---- | ------------ |",
	]
	

fun formatResults(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.count)" ++
		" | $(raceResult.first.finish as DateTime as String {format: 'MMMM d HH:mm:ss'})" ++
		" | $(raceResult.last.finish as DateTime as String {format: 'MMMM d HH:mm:ss'})" ++
		" | $(raceResult.mean)s" ++
		" |"
fun markdown(standings) =
	(header ++ formatResults(standings orderBy (-1 * $.count)))
 		joinBy "\n"