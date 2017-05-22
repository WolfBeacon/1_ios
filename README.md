# iOS

> This repository contains WolfBeacon's iOS Mobile development progress.



## Roadmap

- **Views**
	- Tabbed Application, tabs including:
		1. Featured/attending/recommended hackathons. Will be the 'home' page (start point after login) *(comparable to iOS App Store.)*
		2. Complete list of all hackathons *(searchable, sortable)*
		3. Calendar view of upcoming events and events favorited/attending/registered for. 
		4. Profile view; sub links to favorites, settings, feedback, edit profile, about us, etc. 

		--
	
	1. **Featured/attending/recommended**
		- App store home page like list
		- Auto cyclic scrolling collection view on top
		- List/crid view on bottom
		- Clicking them goes to a details view
	2. **Complete list**
		- Contains sortable and searchable list of hackathons
	3. **Calendar view**
		- Shows a date wise view of upcoming/all/attending hackathons in different color.
	4. **Profile view**
		- Has information about currently logged in user, logout option.
		- Navigation options to favorites, settings, feedback, edit profile, about us, etc.

	----
- **Models**
	- Hackathon
		- *Primary model for storing and displaying.* Fields containing: name, short description, long description, logo, type, size, date, time, location, timetable, links, maps, travel, judges, prizes, hardware, user data, contact information, etc. *(Store around Realm database or Core Data, whichever's feasible.)*
	- Request
		- For managing network calls, built around AFNetowrking/AlamoFire


## Contributing

* Your `master` branch should point to `origin/master`.

* **NEVER EVER WORK ON `master`**. Keep the `master` branch updated with upstream `git pull upstream master`. It's only to be used a reference/starting point.

* In reference to the above point, create a different branch for the issue you are working on off your master branch like `git checkout -b username-work`.

* Whenever you begin work, be sure to `git pull --rebase upstream master`.

* When you have completed, `git push origin username-work` and issue a PR to `wolfbeacon/1_ios`.

* In case you have a PR pending on this branch, `checkout` to your local `master` branch, `checkout` another `work` branch and work there. Needless to say, `git pull --rebase upstream master` is always important.


### Building

See the build instructions in the project's folder.
