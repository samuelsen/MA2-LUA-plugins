-- Helps create a dim ramp executor for a selection of fixtures.
function CreateRampExecutor()

    -- First verify that the user has selected any fixtures, and end processing with a message if number of selectedfixtures is 0
    local numberOfFixtures = gma.show.getvar('SELECTEDFIXTURESCOUNT')
    if numberOfFixtures == "0" then
        gma.gui.msgbox('No fixtures selected',
                       'You need to select at least one fixture to create the ramp executor')
        return
    end

    -- Prompt the user for needed data with defaults. ($SELECTEDEXEC refrences the current selected executor)
    local exec = gma.textinput('select executor', '$SELECTEDEXEC');
    local lable = gma.textinput('label', 'Ramp');
    local appearance = gma.textinput(
                           'Appearance color (leave blank for prompt)',
                           '/r=100 /g=4 /b=90')
    local dimHigh = gma.textinput('dimmer high value', '100');
    local fadein = gma.textinput('fadein', '0');
    local fadeout = gma.textinput('fadeout', '1');

    -- run the GMA commands
    gma.cmd('At ' .. dimHigh .. ' Fade ' .. fadein)
    gma.cmd('Store exec ' .. exec .. ' /o')
    gma.cmd('Assign GO exec ' .. exec .. ' /cm="release"')
    gma.cmd('Assign exec ' .. exec .. '/ignoreexectime=on /OffTime=' .. fadeout)
    gma.cmd('Label exec ' .. exec .. ' "' .. lable .. '"')
    gma.cmd('Appearance exec ' .. exec .. appearance)
    gma.cmd('ClearAll')
end

return CreateRampExecutor
