# IFTTT iOS Project

## Overview
IFTTT is a platform which allows users to create customized integrations called Applets using "triggers" and actions". 
Every Applet run begins with a trigger. Triggers represent an event that may be specific to the user (a new photo taken with their phone) or something that's changed in the world (a stock price passes a threshold).
An Applet may have one or more actions which represent work we do on a user's behalf. For example, turning on their lights or opening a garage door.

## Requirements
In this exercise you're tasked with implementing the following:
- Rendering the array of applets in `applets.json`. For each applet displayed, please display the name, author, connected/disconnected state, and the channel icons associated with the applet.
- An applet detail view controller that displays the name, id, author, description, and channel icons associated with the applet.
- The styling of the views is left up to your discretion.

## Helpful tidbits
- In the applet response, `status` can be one of the following:
    - `enabled_for_user` - Currently turned on
    - `disabled_for_user` - Turned off after being turned on
    - `never_enabled_for_user` - Deleted by user or never turned on
- Applets that are `disabled_for_user` or `never_enabled_for_user` can be displayed with the same grayed out style indicated in the applet list view screenshot.
- There are four icons for each channel. These can be downloaded from the values for the following keys for each channel:
    - `monochrome_image_url`
    - `lrg_monochrome_image_url`
    - `image_url`
    - `lrg_image_url`

- You are free to use any third party libraries or look at any tutorials to assist in completing the exercise.
- Please limit yourself to 4 hours to complete this exercise.

## Extra challenges
If you complete the exercise with time to spare, try implementing the following:
- Unit tests and/or integration tests
- Anything else you can think of that would enhance the app! (Animations, accessibility, etc.)
