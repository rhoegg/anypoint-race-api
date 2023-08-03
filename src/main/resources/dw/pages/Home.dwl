fun formatNewestRacer(standings) = do {
	var newestRace = (standings orderBy $.first.start)[0] 
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
	" - Finish your race"
]

fun markdown(standings) =
	(formatNewestRacer(standings) ++ instructions)
		joinBy "\n"