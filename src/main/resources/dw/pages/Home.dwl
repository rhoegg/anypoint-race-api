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
	"This is a API programming challenge. Use the API Portal documentation to understand how to use this API to do the following:",
	"",
	" - Gain access to the Race API",
	" - Implement your Racer API",
	" - Register yourself as a racer",
	" - Start a race",
	" - Finish your race",
	"",
	"### The Track",
	"![This is your track](resources/season2-track-5261e971-e715-4acf-9be1-b962c3b5b4e1.png)",
	"",
	"## Need help? Notice a problem?",
	"",
	"You can file an issue [here](https://github.com/rhoegg/anypoint-race-api/issues)."
]

fun markdown(standings) =
	(formatNewestRacer(standings) ++ instructions)
		joinBy "\n"