fun formatNewestRacer(standings) = do {
	var newestRace = (standings orderBy $.first.start)[-1]
	---
	[
		"",
		"## Welcome to our Newest Racer $(newestRace.racer.displayName)",
		""
	]
}

var instructions = [
	"## Instructions",
	"",
	"This is a API consumer programming challenge. Use the API Portal documentation to understand how to use this API to do the following:",
	"",
	" - Gain access to the Race API",
	" - Register yourself as a racer",
	" - Start a race",
	" - Finish your race",
	"",
	"## Need help? Notice a problem?",
	"",
	"You can file an issue [here](https://github.com/rhoegg/anypoint-race-api/issues)."
]

fun markdown(standings) =
	(formatNewestRacer(standings) ++ instructions)
		joinBy "\n"