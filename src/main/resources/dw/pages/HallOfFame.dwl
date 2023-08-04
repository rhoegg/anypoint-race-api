import slice, some from dw::core::Arrays
var timestampFormat = 'MMMM d HH:mm:ss O'

var latestRacerHeader = [
		"## Latest Racer",
		""
	]

fun formatLatestRacer(standings) = do {
	var latestRace = (standings orderBy $.last.finish)[-1] 
	---
	latestRacerHeader ++
	[
		"- Name: $(latestRace.racer.displayName)",
		"- Finished: $(latestRace.last.finish as DateTime as String {format: timestampFormat})",
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
	speedyHeader ++
	(
		slice(standings orderBy $.best.elapsed, 0, 10) map (raceResult, index) ->
			"| " ++
			(index + 1) ++
			" | $(raceResult.racer.displayName)" ++
			" | $(raceResult.best.elapsed)s"
	)

var firstHeader = [
		"",
		"## First Racers",
		"",
		"| Rank | Name | First Race |",
		"| ---- | ---- | ---------- |",
	]

fun formatFirst(standings) =
	firstHeader ++
	(
		slice(standings orderBy $.first.finish, 0, 10) map (raceResult, index) ->
			" | " ++
			(index + 1) ++
			" | $(raceResult.racer.displayName)" ++
			" | $(raceResult.first.finish as DateTime as String {format: timestampFormat})"
	)

var perseveranceHeader = [
		"",
		"## Most Perseverant",
		"",
		"| Rank | Name | Races |",
		"| ---- | ---- | ----- |",
	]
	

fun formatPerseverance(standings) =
	perseveranceHeader ++
	(
		slice(standings orderBy (-1 * $.count), 0, 10) map (raceResult, index) ->
			"| " ++
			(index + 1) ++
			" | $(raceResult.racer.displayName)" ++
			" | $(raceResult.count)" ++
			" |"
	)

fun lapHeaderFirst(threshold) = [
	"",
	"## First to $(threshold)"
]

fun lapHeaderFastest(threshold) = [
	"",
	"## Fastest $(threshold) laps"
]

fun formatLaps(standings, threshold = 10) = do {
	var qualifiedRacers = standings filter (racer) -> ( 
			racer.races some (race) -> (
				race.finish? and race.laps? and (race.laps >= threshold)
			)
		)
	var qualifiedStandings = qualifiedRacers map (racer) ->
		racer update {
			case races at .races -> races filter (race) ->
				(race.finish? and race.laps? and (race.laps >= threshold))
		}
	var first = flatten(qualifiedStandings map $.races) minBy $.finish
	var fastest = flatten(qualifiedStandings map $.races) minBy $.elapsed
	---
	if (sizeOf(qualifiedStandings) > 0)
		lapHeaderFirst(threshold) ++ 
		[
			"$(first.racer.displayName) - $(first.finish as DateTime as String {format: timestampFormat})"
 		] ++
		lapHeaderFastest(threshold) ++
		[
			"$(fastest.racer.displayName) - $(fastest.elapsed)s"
		] ++
		formatLaps(qualifiedStandings, threshold * 10)
	else
		[]
}
	
		
fun markdown(standings) =
	(
		formatLatestRacer(standings) ++
		formatSpeedy(standings) ++
		formatFirst(standings) ++
		formatPerseverance(standings) ++
		formatLaps(standings)
	) joinBy "\n"