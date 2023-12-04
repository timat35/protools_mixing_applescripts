
script V
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
	property test : missing value
end script


tell application "finder"
	tell application "System Events"
		set  PT to the first application process whose creator type is "PTul"
		tell  PT
			activate
			set boolAutomationOpen to true
			set frontmost to true
			-- open automation windows if not open
			set V's automationMenuItem to menu item "Automation" of menu "Window" of menu bar item "Window" of menu bar 1
			set status to value of attribute "AXMenuItemMarkChar" of V's automationMenuItem
			if status is not equal to "✓" then
				set boolAutomationOpen to false
				click V's automationMenuItem
				delay 0.2
			end if
			log "test0"
			-- find edit windows
			set V's editWindow to first window whose name starts with "edit:"
			-- set V's trackListTable to first table of V's editWindow whose description is "Track List"
			-- set V's selectedRow to first row of V's trackListTable whose selected = true
			-- set selectedIndex to value of attribute "AXIndex" of selectedRow

			set V's trackName to "VI ST"
			log "test1"
			-- set V's trackName to name of button 1 of UI element 1 of V's selectedRow
			-- -- function to replace in string (grrr)
			-- set AppleScript's text item delimiters to "Shown. "
		    -- set theTextItems to every text item of V's trackName
		    -- set AppleScript's text item delimiters to ""
		    -- set V's trackName to theTextItems as string
		    -- set AppleScript's text item delimiters to ""
			
			set groupTitle to V's trackName & " - Audio Track "
			log "test2" -- slow


			set V's outputButton to button  "Output Window button" of group "Audio IO" of group groupTitle of V's editWindow

			log "test25" -- slow

			set V's outputValue to value of V's outputButton

			log "test3" -- slow

			if V's outputValue is not equal to "open" then
			    perform action "AXPress" of V's outputButton
			end if


			log "test4" -- very slow !! see click click or end event

			-- Search within windows 
			set V's allWindows to every window of PT
			set V's test to first window of PT whose button whose title is ""

			-- log V's testÒ

			repeat with  currentWindow in V's allWindows

				if (count (buttons of  currentWindow whose title contains "Suspend Automation")) is greater than 0 then
					-- Click and exit the script.
					set V's automationWindow to  currentWindow
				end if

				if (count (buttons of currentWindow whose title contains "Automation Safe")) is greater than 0 then
					-- Click and exit the script.
					set V's panWindow to  currentWindow
				end if

			end repeat

			log "test5"

			set V's previewButton to button "Enable Auto Preview Mode" of V's automationWindow

			if value of attribute "AXvalue" of V's previewButton is not equal to "selected" then
				click V's previewButton
			end if



			log "test6"	
				
			set V's frontPan to text field "Front Pan Numerical" of V's panWindow
			set test to value of attribute "AXValue" of V's frontPan 
			perform action "AXPress" of V's frontPan
			keystroke "-80"
			key code 76

			log "test7"

			set FRPan to text field "F/R Pan Numerical" of V's panWindow
			perform action "AXPress" of FRPan
			keystroke "100"
			key code 76

			log "test8"

			set CenterPan to text field "Front Center % Numerical" of V's panWindow
			perform action "AXPress" of CenterPan
			key code 48
			keystroke "80"
			key code 76

			perform action "AXPress" of CenterPan
			repeat 3 times
				key code 48
			end repeat
			keystroke "100"
			key code 76

			click menu item "Write to All Enabled" of menu "Automation" of menu item "Automation" of menu "Edit" of menu bar item "Edit" of menu bar 1

			click V's previewButton
			perform action "AXPress" of V's outputButton

			if boolAutomationOpen is not true then 
				click automationMenuItem
			end if


		end tell
		--your code
	end tell
	--your code
end tell

