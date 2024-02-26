
import * from dw::core::Periods

type RaceState = { endpoint: String, raceType: String, racerId: String, start: DateTime | String, time?: Number, downMessage?: String }

fun practiceExpiration(nothing: Null) = now()

fun practiceExpiration(raceState: RaceState) = do {
	var start = raceState.start as DateTime
	---
	start + seconds(Mule::p("practice.expiry") as Number)
}

fun formatPracticeRaceState(n: Null) = 
	{
		status: "Inactive",
		expires: 0
	}
	
fun formatPracticeRaceState(raceState: RaceState) = do {
	var secondsLeft = (practiceExpiration(raceState) - now()) as Number {unit: "milliseconds"} / 1000
	---
	if (secondsLeft <= 0) formatPracticeRaceState(null)
	else {
		endpoint: raceState.endpoint,
		status: if (raceState.downMessage?) "Down" else "Active",
		expires: secondsLeft,
		(laps: raceState.laps) if raceState.laps?,
		(scale: raceState.scale) if raceState.scale?,
		(time: raceState.time) if raceState.time?,
		(error: raceState.downMessage) if raceState.downMessage?
	}
}