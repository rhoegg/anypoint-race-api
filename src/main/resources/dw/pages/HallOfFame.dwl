import slice from dw::core::Arrays

var latestRacerHeader = [
		"## Latest Racer",
		""
	]

fun formatLatestRacer(standings) = do {
	var latestRace = (standings orderBy $.last.finish)[-1] 
	---
	[
		"- Name: $(latestRace.racer.displayName)",
		"- Finished: $(latestRace.last.finish as DateTime as String {format: 'MMMM d HH:mm:ss O'})",
		"- Time: $(latestRace.last.elapsed)s"
	]
}

var speedyHeader = [
		"",
		"## Speediest",
		"",
		"| Rank | Name | Best Time |",
		"| ---- | ---- | --------- |",
	]

fun formatSpeedy(standings) = 
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.best.elapsed)s"

var ogHeader = [
		"",
		"## OG Racers",
		"",
		"| Rank | Name | First Race |",
		"| ---- | ---- | ---------- |",
	]

fun formatFirst(standings) =
	standings map (raceResult, index) ->
		" | " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.first.finish as DateTime as String {format: 'MMMM d HH:mm:ss O'})"

var perseveranceHeader = [
		"",
		"## Most Perseverant",
		"",
		"| Rank | Name | Races |",
		"| ---- | ---- | ----- |",
	]
	

fun formatPerseverance(standings) =
	standings map (raceResult, index) ->
		"| " ++
		(index + 1) ++
		" | $(raceResult.racer.displayName)" ++
		" | $(raceResult.count)" ++
		" |"
		
fun markdown(standings) =
	(latestRacerHeader ++ formatLatestRacer(standings)) ++
	(speedyHeader ++ formatSpeedy(slice(standings orderBy $.best.elapsed, 0, 4))) ++
	(ogHeader ++ formatFirst(slice(standings orderBy $.first.finish, 0, 4))) ++
	(perseveranceHeader ++ formatPerseverance(slice(standings orderBy (-1 * $.count), 0, 4)))
 		joinBy "\n"