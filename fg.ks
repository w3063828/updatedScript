print "IR Iavailable: " + ADDONS:IR:AVAILABLE.

Print "Groups:".

for g in ADDONS:IR:GROUPS
{
    Print g:NAME + " contains " + g:SERVOS:LENGTH + " servos:".
    for s in g:servos
    {
        print "    " + s:NAME + ", position: " + s:POSITION.
        if (g:NAME = "Hinges" and s:POSITION = 0)
        {
            s:MOVETO(30, 2).
        }
        else if (g:NAME = "Hinges" and s:POSITION > 0)
        {
            s:MOVETO(0, 1).
        }
    }
}