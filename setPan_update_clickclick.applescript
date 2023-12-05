
# in this script, I want to automatically set pan of a stereo track to -80 80..
# the pan interface is a dolby 5.1
# This is a first step, the goal at the end would be to set automatically to predefined value the pan for stereo - dolby - atmo..
# But this is too slow (considering working on a movie having at least 500 tracks..)

#install click cliak
#https://github.com/BlueM/cliclick

property PT : missing value
property automationMenuItem : missing value
property editWindow : missing value
property trackListTable : missing value
property selectedRow : missing value
property trackName : missing value
property outputButton : missing value
property outputValue : missing value
property previewButton : missing value
property allWindows : missing value
property currentWindow : missing value
property automationWindow : missing value
property panWindow : missing value
property frontPan : missing value

property cliclickCLIPath : missing value
set cliclickCLIPath to "usr/local/bin/cliclick"

set startTime to current date

set boolAutomationOpen to true

tell application "finder" -- DROP SYSTEM EVENT // try to change
	set  PT to the first application process whose creator type is "PTul"
	tell  PT
		activate
		set frontmost to true
	end tell
end tell 
	--your code

tell PT 
	-- open automation windows if not open
	set  automationMenuItem to menu item "Automation" of menu "Window" of menu bar item "Window" of menu bar 1
	set status to value of attribute "AXMenuItemMarkChar" of  automationMenuItem
end tell 


if status is not equal to "✓" then # try -- sign different
	set boolAutomationOpen to false
	ignoring application responses
    tell application "System Events" to tell PT
        click  automationMenuItem
    end tell
	end ignoring
	do shell script "killall System\\ Events"
	delay 0.2
end if

tell PT 

	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "0: " & timeTaken 
	-- find edit windows
	set  editWindow to first window whose name starts with "edit:"
	-- set  trackListTable to first table of  editWindow whose description is "Track List"
	-- set  selectedRow to first row of  trackListTable whose selected = true
	-- set selectedIndex to value of attribute "AXIndex" of selectedRow

	set  trackName to "VI ST"
	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "1: " & timeTaken  
	-- set  trackName to name of button 1 of UI element 1 of  selectedRow
	-- -- function to replace in string (grrr)
	-- set AppleScript's text item delimiters to "Shown. "
    -- set theTextItems to every text item of  trackName
    -- set AppleScript's text item delimiters to ""
    -- set  trackName to theTextItems as string
    -- set AppleScript's text item delimiters to ""
	
	set groupTitle to  trackName & " - Audio Track "
	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "2: " & timeTaken  


	set  outputButton to button  "Output Window button" of group "Audio IO" of group groupTitle of  editWindow
	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "3: " & timeTaken  

	set  outputValue to value of  outputButton

	

end tell

set timeTaken to ((current date) - startTime as string) & " Seconds"
log "4: " & timeTaken  
if  outputValue is not equal to "open" then
    tell application "System Events" to tell PT -- if not working try outputButton of PT
    tell outputButton
			set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
		end tell
    end tell
	my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))
end if


set timeTaken to ((current date) - startTime as string) & " Seconds"
log "5: " & timeTaken  

## might not work

			-- Search within windows 
tell PT 
	set  allWindows to every window of PT
	-- set    to first window of PT whose button whose title is ""

	repeat with  currentWindow in  allWindows

		if (count (buttons of  currentWindow whose title contains "Suspend Automation")) is greater than 0 then
			set  automationWindow to  currentWindow
		end if

		if (count (buttons of currentWindow whose title contains "Automation Safe")) is greater than 0 then
			set  panWindow to  currentWindow
		end if

	end repeat

	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "6: " & timeTaken   

	set  previewButton to button "Enable Auto Preview Mode" of  automationWindow
end tell 

tell application "System Events" 
	tell PT
		if value of attribute "AXvalue" of  previewButton is not equal to "selected" then
		    tell previewButton
					set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
				end tell
		    end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))
		end if


		set timeTaken to ((current date) - startTime as string) & " Seconds"
		log "7: " & timeTaken   
					
		set  frontPan to text field "Front Pan Numerical" of  panWindow
		tell frontPan
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))

	end tell 	
	keystroke "-80"
	key code 76

	tell PT

		set  frontPan to text field "F/R Pan Numerical" of  panWindow
		tell frontPan
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))

	end tell 	


	keystroke "100"
	key code 76

	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "8: " & timeTaken   

	tell PT

		set  frontPan to text field "Front Center % Numerical" of  panWindow
		tell frontPan
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))

	end tell 

	set timeTaken to ((current date) - startTime as string) & " Seconds"
	log "9: " & timeTaken   

	key code 48
	keystroke "80"
	key code 76

	tell PT
		tell frontPan
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))

	end tell 

	repeat 3 times
		key code 48
	keystroke "100"
	key code 76

	tell PT -- need different   here
		set timeTaken to ((current date) - startTime as string) & " Seconds"
		log "10: " & timeTaken   
		click menu item "Write to All Enabled" of menu "Automation" of menu item "Automation" of menu "Edit" of menu bar item "Edit" of menu bar 1
		set timeTaken to ((current date) - startTime as string) & " Seconds"
		log "11: " & timeTaken   
		tell previewButton
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		my cliClick("rc:" & xPosition + (xSize div 2) & "," & yPosition + (ySize div 2))
		set timeTaken to ((current date) - startTime as string) & " Seconds"
		log "12:  " & timeTaken   
		tell outputButton
				set {{xPosition, yPosition}, {xSize, ySize}} to {position, size}
			end tell
		end tell
		if boolAutomationOpen is not true then 
			click automationMenuItem
		end if
	end tell
end tell 





