@echo off

echo Close the game VR session first. Connect VD, then put on the headset.

echo P cycles scene / old quad-only / compatible flat. Escape exits.

"%~dp0tools\vrvd-vulkan-probe.exe" --run 120

pause

