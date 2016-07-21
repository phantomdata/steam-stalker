[![CircleCI](https://circleci.com/gh/phantomdata/steam-stalker.svg?style=svg)](https://circleci.com/gh/phantomdata/steam-stalker) [![Code Climate](https://codeclimate.com/github/phantomdata/steam-stalker/badges/gpa.svg)](https://codeclimate.com/github/phantomdata/steam-stalker)
# Steam Stalker

## Introduction

This is a web application designed to provide a better view into the data that Steam provides.  The primary goals are to provide a simple overview of:

1. A player's most played games
1. A player's latest game playing
1. Information of the same for a player's specified friends

## Items of Note

1. You will need to copy dot.env.skel to .env and setup your Steam API key
1. There is a rake task (`steam_stalker:update_libraries`) that should be ran nightly to update everyone's steam libraries

## TODO

1. Create rake task to run nightly and update all libraries
1. HTML skinning
1. QA testing - specifically around creation of invalid or non-existant SteamIds
1. General code cleanup
1. Setup ansible
