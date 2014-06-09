Config {
  font = "xft:DejaVu Sans:size=10"
, bgColor = "#002b36"
, fgColor = "#657b83"
, position = TopW L 90
, lowerOnStart = True
, commands = [ Run BatteryP ["BAT0"] ["-t", "<left>"] 50
            , Run Cpu ["-L","3","-H","50","--high","#f0c040"] 10
            , Run Memory ["-t","Mem: <usedratio>%"] 10
            , Run Swap [] 10
            , Run Date "%a, %b %_d %H:%M" "date" 10
            , Run StdinReader
            ]
, sepChar = "%"
, alignSep = "}{"
, template = "%StdinReader%}{BAT: %battery% · %cpu% · %memory% · %swap% · %date%"
, allDesktops = True
}

