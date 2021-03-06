@echo off
setlocal enabledelayedexpansion

rem only enlist on certain machines
if /i "%computername%"=="mateer-d" goto ENLIST
if /i "%computername%"=="mateer-v" goto ENLIST

goto END

:ENLIST
set codebase=%1
set branch=%2

if (%codebase%)==() (
	set codebase=rs2
)

if (%branch%)==() (
	set branch=rs_onecore_sigma_media_dev
)

if not exist %userprofile%\source\%branch% (
	echo Enlisting in %branch%...

	set sdxroot=%userprofile%\source\%branch%
	set depots=+avcore +en-us +loctools +multi
	set options=-q -allowlongsdxroot -nofastenlist
	call \\glacier\sdx\sdx enlist !codebase! !branch! !depots! !options!
)

:END
