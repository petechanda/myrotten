## How to use our codes

1. Download all of code [here.](https://github.com/RyuKoki/myrottenpotatoes/archive/refs/heads/main.zip)

2. Open terminal in the folder which you are given by extacting `ZIP FILE` which you downloaded.

3. Run the following `commands` on your terminal : 
	- __You have to user this `command` if you edit your Gemfile.__
		```
		bundle install
		```
	- __You should use `yarn` for re-checking all of coding files.__
		```
		yarn install --check-files
		```
	- __You should always tell sever to route if you change or edit path(s).__
		```
		rake routes
		```
		if it errors, type `rails webpacker:install` before.
	- __Using migration__ *This is only for out project.*
		```
		rake db:migrate
		```
	- __Using seed file for starting with a few of movies__ *This is only for out project.*
		```
		rake db:seed
		```
	- __Try to run server__
		```
		rails server
		```
		> Open your browser and type link : localhost:3000
