
import * from dw::core::Periods

type RacerState = { endpoint: String, start: DateTime | String }

fun formatPracticeRacerState(racerState: RacerState | Null) = do {
	var start = racerState.start as DateTime
	var expiration = start + seconds(Mule::p("practice.expiry") as Number)
	var secondsLeft = (expiration - now()) as Number {unit: "milliseconds"} / 1000
	---
	if (racerState == null or secondsLeft <= 0) {
		(endpoint: racerState.endpoint) if racerState.endpoint?,
		status: "Inactive",
		expires: 0
	} else {
		endpoint: racerState.endpoint,
		status: "Active",
		expires: secondsLeft
	}
}