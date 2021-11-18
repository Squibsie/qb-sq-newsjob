# qb-sq-newsjob
For QB-Framework.

This is a news reporter job, similar to the one widely available for QB-Framework. However this one has been written from scratch by me to get to grips with the framework. As such, it doesn't aim to anything spectacular, but it is lightweight and works.

# Features/Usage Instructions:
- Whitelisted job, use the admin command /setjob to assign people to this job.
- 2 grades, allowing for runners/crew to be present. Only the Journalist grade can use /broadcast.
- Vehicle storage and spawn at the Weazel News HQ. Approach the area and a text prompt indicates where you should press E.
- /Broadcast command, this allows people of the Journalist rank to broadcast a message to all players connected through the game chat. These are highlighted as Weazel News.
- Fully integrated with QB Framework for pay, vehicle keys and fuel.

# Installation
1. To install this news job, first ensure that any QB Framework pack you use does not already have a similar job installed.
2. Download latest release, and put the folder in your [qb] folder.
3. Within your [qb] folder, locate qb-core and then open the shared.lua file within this folder.
4. Scroll to the jobs section, or search for 'reporter'. If the reporter job already exists, replace it with the following. If it does not, add the follwoing:

```
['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Runner',
                payment = 25
            },
            ['1'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
```
5. Start your server, and you should now be able to use /setjob to give somebody the reporter job. Remember to set the grade too. Once the target user reconnects, A map location will be available to them, and they collect a branded news van from there.



