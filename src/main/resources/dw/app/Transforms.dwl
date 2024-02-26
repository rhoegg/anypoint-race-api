
import * from dw::core::Periods

type RaceState = { endpoint: String, raceType: String, racerId: String, start: DateTime | String, time?: Number, downMessage?: String }

fun practiceExpiration(nothing: Null) = now()

fun practiceExpiration(raceState: RaceState) = do {
	var start = raceState.start as DateTime
	---
	start + seconds(Mule::p("practice.expiry") as Number)
}

fun formatPracticeRaceState(raceState: RaceState | Null) = do {
	var secondsLeft = (practiceExpiration(raceState) - now()) as Number {unit: "milliseconds"} / 1000
	---
	if (raceState == null or secondsLeft <= 0) {
		(endpoint: raceState.endpoint) if raceState.endpoint?,
		status: "Inactive",
		expires: 0
	} else {
		endpoint: raceState.endpoint,
		status: if (raceState.downMessage?) "Down" else "Active",
		expires: secondsLeft,
		(laps: raceState.laps) if raceState.laps?,
		(time: raceState.time) if raceState.time?,
		(error: raceState.downMessage) if raceState.downMessage?
	}
}