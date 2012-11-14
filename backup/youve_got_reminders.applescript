set theApp to "Microsoft Office Reminders"


on sendGrowlAllert(message)
	tell application "System Events"
		set growlIsRunning to Â
			(count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
	end tell
	
	if growlIsRunning then
		tell application id "com.Growl.GrowlHelperApp"
			set appName to "You've got reminders Applescript"
			-- Make a list of all the notification types 
			-- that this script will ever send:
			set the allNotificationsList to Â
				{"You've got reminders"}
			
			-- Make a list of the notifications 
			-- that will be enabled by default.      
			-- Those not enabled by default can be enabled later 
			-- in the 'Applications' tab of the Growl preferences.
			set the enabledNotificationsList to Â
				{"You've got reminders"}
			
			-- Register our script with growl.
			-- You can optionally (as here) set a default icon 
			-- for this script's notifications.
			register as application Â
				appName all notifications allNotificationsList Â
				default notifications enabledNotificationsList Â
				icon of application "Script Editor"
			
			--       Send a Notification...
			notify with name Â
				"You've got reminders" title Â
				message description Â
				"Get on your reminders!" application name appName
		end tell
	end if
end sendGrowlAllert
-- Kill the existing window, if it is there.
-- tell application theApp to quit

-- Wait for app to close.... Only wait about a 15 seconds.
-- repeat with x from 0 to 30
-- 	log "loop1"
-- 	if not appIsRunning(theApp) then
-- 		exit repeat
-- 	end if
-- 	delay 0.5
-- end repeat
-- log "out of loop1"
-- 
-- -- Open up the app
-- tell application theApp to activate
-- log "told app to start"
-- 
-- -- Wait for app to start.... Only wait about a 5 seconds
-- repeat with x from 0 to 10
-- 	log "loop2"
-- 	if appIsRunning(theApp) then
-- 		exit repeat
-- 	end if
-- 	delay 0.5
-- end repeat
-- -- If the app stays open for more than 3 seconds, then there must be a reminder.
-- delay 3

if appIsRunning(theApp) then
	sendGrowlAllert("You've got reminders!!!!")
	
end if


on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning
