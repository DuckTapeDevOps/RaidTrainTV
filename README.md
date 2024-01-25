<h1 align='center'>
    RaidTrainTV
</h1> 

<div align='center'>
    <img src='media\images\RaidTrain.png' width='200' align='center'>
</div>
<br />
<h2 align='center'>Project Description</h2>

A Raid Train on Twitch is essentially a music festival or equivalent that includes new artists every ~hour and the train simply raids into the next artist. Raidtrain.tv will be a website for organizers to host their raid trains and for patrons to find where the train is such that they can join at any time. This experience should be seemless and hopefully include an embedded version of the active entertainer.

<div align='center'>
    <img src='media/images/real-mvp.gif' width='400' align='center'>
</div>

MVP: Minimal Viable Product

There will be a single page per organizer that will display the raid trains that organizer has set up. This page, for patrons (ID based) will be read only.

<br />
<h2 align='center'>Sections</h2>
<div align='center'>
    ·
    <a href='#contribute'>How to Contribute</a>
    ·
    <a href='#tech-stack'>Tech Stack</a>
    ·
    <a href='#brain-dump'>Brain Dump</a>
    ·
    <a href='#backlog'>Back Log</a>
    ·
</div>
<br />

<h2 id='contribute'>How to Contribute</h2>
<h3>Initial Setup</h3>
<ul>
    <li>Fork the repo</li>
    <li>Clone to your machine</li>
    <li>Create a new branch</li>
    <li>Get contributing!</li>
</ul>

<h3>TLDR How to CRUD RaidTrains & Timeslots</h3>
    <ul>
        <li>Navigate to /assets/raid_trains.yaml</li>
        <li>Duplicate / Remove / Alter the data you need. The website will render the data from top to bottom.</li>
        <li>When you are done, save the file, push to github, and open a PR 😀</li>
    </ul>

<h3>Database Structure</h3>

<h3>Creating a new train</h3>

``` yaml
# Each Raid train requires a 'host' followed by an array of 'raids'

- host: HostChannelName #DuckTapeDevOps
    raids:  #The list of raids
        - name: Raid Theme Name #Pitch Practice
```

<h3>Creating new event days</h3>

``` yaml
# Each raid train can have as many 'days' as you want, days can also be a 'sub event' within the raid train

# Days goes underneath the raids key

raids:  # The list of raids
    - name: Raid Theme Name # Pitch Practice
    days:
        - day: Monday, January 1, 2024
            events: # Each event or raid timeslot would go in this list
```

<h3>Creating new slots</h3>

``` yaml
# Within the events list we can create as many time slots as we want for that event.
# Each timeslot requires a time, user, and link to their channel.

events:  #The list of events
    - time: Thursday, January 25, 2024 14:00
        user: DuckTapeDevOps
        link: https://www.twitch.tv/ducktapedevops  # Link to the users channel.
```



<h2 id='tech-stack'>Tech Stack (Needs)</h2>

![Alt Text](./media/images/surprise-whats-in-the-box.gif)

- Firebase
- React.js
- Firestore Database

------

<h2 id='brain-dump'>Brain Dump (Wants)</h2>

![Alt Text](./media/images/ThisIsFine.jpeg)

- S3 Front End
- CloudFront

<h2 id='backlog'>Backlog</h2>

- Discord Bot
- Twitch Bot

---
![Alt Text](./media/images/dumpsterfire-dumpster.gif)

