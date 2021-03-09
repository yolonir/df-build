-- DFHack-native implementation of the classic Quickfort utility
--[====[

quickfort
=========
Processes Quickfort-style blueprint files.

Quickfort blueprints record what you want at each map coordinate in a
spreadsheet, storing the keys in a spreadsheet cell that you would press to make
something happen at that spot on the DF map. Quickfort runs in one of five
modes: ``dig``, ``build``, ``place``, ``zone``, or ``query``. ``dig`` designates
tiles for digging, ``build`` builds buildings and constructions, ``place``
places stockpiles, ``zone`` manages activity zones, and ``query`` changes
building or stockpile settings. The mode is determined by a marker in the
upper-left cell of the spreadsheet (e.g.: ``#dig`` in cell ``A1``).

You can create these blueprints by hand or by using any spreadsheet application,
saving them as ``.xlsx`` or ``.csv`` files. You can also build your plan "for
real" in Dwarf Fortress, and then export your map using the DFHack
`blueprint` plugin for later replay. Blueprint files should go in the
``blueprints`` subfolder in the main DF folder.

For more details on blueprint file syntax, see the `quickfort-blueprint-guide`
or browse through the ready-to-use examples in the `quickfort-library-guide`.

Usage:

**quickfort set [<key> <value>]**
    Allows you to modify the active quickfort configuration. Just run
    ``quickfort set`` to show current settings. See the Configuration section
    below for available keys and values.
**quickfort reset**
    Resets quickfort configuration to the defaults in ``quickfort.txt``.
**quickfort list [-m|-\-mode <mode>] [-l|-\-library] [-h|-\-hidden] [search string]**
    Lists blueprints in the ``blueprints`` folder. Blueprints are ``.csv`` files
    or sheets within ``.xlsx`` files that contain a ``#<mode>`` comment in the
    upper-left cell. By default, blueprints in the ``blueprints/library/``
    subfolder or blueprints that contain a ``hidden()`` marker in their modeline
    are not shown. Specify ``-l`` or ``-h`` to include library or hidden
    blueprints, respectively. The list can be filtered by a specified mode (e.g.
    "-m build") and/or strings to search for in a path, filename, mode, or
    comment. The id numbers in the list may not be contiguous if there are
    hidden or filtered  blueprints that are not being shown.
**quickfort gui [-l|-\-library] [-h|-\-hidden] [search string]**
    Starts the quickfort dialog, where you can run blueprints from an
    interactive list. The optional arguments have the same meanings as they do
    in the list command, and can be used to preset the gui dialog state.
**quickfort <command> <list_num> [<options>]**
    Applies the blueprint with the number from the list command.
**quickfort <command> <filename> [-n|-\-name <name>] [<options>]**
    Applies a blueprint in the specified file. The optional ``name`` parameter
    can select a specific blueprint from a file that contains multiple
    blueprints with the format "sheetname/label", or just "/label" for .csv
    files. The label is defined in the blueprint modeline, defaulting to its
    order in the sheet or file if not defined. If the -n parameter is not
    specified, the first blueprint in the first sheet is used.

**<command>** can be one of:

:run:     Applies the blueprint at your current in-game cursor position.
:orders:  Uses the manager interface to queue up orders to manufacture items for
          the specified build-mode blueprint.
:undo:    Applies the inverse of the specified blueprint. Dig tiles are
          undesignated, buildings are canceled or removed (depending on their
          construction status), and stockpiles/zones are removed. There is no
          effect for query blueprints since they can contain arbitrary key
          sequences.

**<options>** can be zero or more of:

``-q``, ``--quiet``
    Don't report on what actions were taken (error messages are still shown).
``-v``, ``--verbose``
    Output extra debugging information. This is especially useful if the
    blueprint isn't being applied like you expect.
``-d``, ``--dry-run``
    Go through all the motions and print statistics on what would be done, but
    don't actually change any game state.

Example commands::

    quickfort list
    quickfort list -l dreamfort help
    quickfort run library/dreamfort.csv
    quickfort orders library/dreamfort.csv -n /industry2
    quickfort run 10 -v

Configuration:

The quickfort script reads its startup configuration from the
``dfhack-config/quickfort/quickfort.txt`` file, which you can customize. The
settings may be dynamically modified by the ``quickfort set`` command for the
current session, but settings changed with the ``quickfort set`` command will
not change the configuration stored in the file:

``blueprints_dir`` (default: 'blueprints')
    Directory tree to search for blueprints. Can be set to an absolute or
    relative path. If set to a relative path, resolves to a directory under the
    DF folder. Note that if you change this directory, you will not see
    blueprints written by the DFHack `blueprint` plugin (which always writes to
    the ``blueprints`` dir) or blueprints in the quickfort blueprint library.
``force_marker_mode`` (default: 'false')
    If true, will designate all dig blueprints in marker mode. If false, only
    cells with dig codes explicitly prefixed with ``m`` will be designated in
    marker mode.
``query_unsafe`` (default: 'false')
    Skip query blueprint sanity checks that detect common blueprint errors and
    halt or skip keycode playback. Checks include ensuring a configurable
    building exists at the designated cursor position and verifying the active
    UI screen is the same before and after sending keys for the cursor
    position. Temporarily enable this if you are running a query blueprint that
    sends a key sequence that is *not* related to stockpile or building
    configuration. Most players will never need to enable this setting.
``stockpiles_max_barrels``, ``stockpiles_max_bins``, and ``stockpiles_max_wheelbarrows`` (defaults: -1, -1, 0)
    Set to the maximum number of resources you want assigned to stockpiles of
    the relevant types. Set to -1 for DF defaults (number of stockpile tiles
    for stockpiles that take barrels and bins, 1 wheelbarrow for stone
    stockpiles). The default here for wheelbarrows is 0 since using wheelbarrows
    can *decrease* the efficiency of your fort unless you know how to use them
    properly.

There is one other configuration file in the ``dfhack-config/quickfort`` folder:
:source:`aliases.txt <dfhack-config/quickfort/aliases.txt>`. It defines keycode
shortcuts for query blueprints. The format for this file is described in the
`quickfort-alias-guide`, and default aliases that all players can use and build
on are available in the `quickfort-alias-library`. Some quickfort library
aliases require the `search-plugin` plugin to be enabled.
]====]

-- reqscript all internal files here, even if they're not directly used by this
-- top-level file. this ensures transitive dependencies are reloaded if any
-- files have changed.
local quickfort_aliases = reqscript('internal/quickfort/aliases')
local quickfort_build = reqscript('internal/quickfort/build')
local quickfort_building = reqscript('internal/quickfort/building')
local quickfort_command = reqscript('internal/quickfort/command')
local quickfort_common = reqscript('internal/quickfort/common')
local quickfort_dialog = reqscript('internal/quickfort/dialog')
local quickfort_dig = reqscript('internal/quickfort/dig')
local quickfort_keycodes = reqscript('internal/quickfort/keycodes')
local quickfort_list = reqscript('internal/quickfort/list')
local quickfort_meta = reqscript('internal/quickfort/meta')
local quickfort_notes = reqscript('internal/quickfort/notes')
local quickfort_orders = reqscript('internal/quickfort/orders')
local quickfort_parse = reqscript('internal/quickfort/parse')
local quickfort_place = reqscript('internal/quickfort/place')
local quickfort_query = reqscript('internal/quickfort/query')
local quickfort_set = reqscript('internal/quickfort/set')
local quickfort_zone = reqscript('internal/quickfort/zone')

-- keep this in sync with the full help text above
local function print_short_help()
    print [[
Usage:

quickfort set [<key> <value>]
    Allows you to temporarily modify the active quickfort configuration. Just
    run "quickfort set" to show current settings.
quickfort reset
    Resets quickfort configuration to defaults in quickfort.txt.
quickfort list [-m|--mode <mode>] [-l|--library] [-h|--hidden] [search string]
    Lists blueprints in the "blueprints" folder. Specify -l to include library
    blueprints and -h to include hidden blueprints. The list can be filtered by
    a specified mode (e.g. "-m build") and/or strings to search for in a path,
    filename, mode, or comment.
quickfort gui [-l|--library] [-h|--hidden] [search string]
    Starts the quickfort dialog, where you can run blueprints from an
    interactive list. The optional arguments have the same meanings as they do
    in the list command, and can be used to preset the gui dialog state.
quickfort <command> <list_num> [<options>]
    Applies the blueprint with the number from the list command.
quickfort <command> <filename> [-n|--name <name>] [<options>]
    Applies a blueprint in the specified file. The optional name parameter can
    select a specific blueprint from a file that contains multiple blueprints
    with the format "sheetname/label", or just "/label" for .csv files. If -n is
    not specified, the first blueprint in the first sheet is used.

<command> can be one of:

run     Applies the blueprint at your current in-game cursor position.
orders  Uses the manager interface to queue up orders to manufacture items for
        the specified build-mode blueprint.
undo    Applies the inverse of the specified blueprint. Dig tiles are
        undesignated, buildings are canceled or removed (depending on their
        construction status), and stockpiles/zones are removed. There is no
        effect for query blueprints since they can contain arbitrary key
        sequences.

<options> can be zero or more of:

-q, --quiet
    Don't report on what actions were taken (error messages are still shown).
-v, --verbose
    Output extra debugging information. This is especially useful if the
    blueprint isn't being applied like you expect.
-d, --dry-run
    Go through all the motions and print statistics on what would be done, but
    don't actually change any game state.

For more info, see:
https://docs.dfhack.org/en/stable/docs/_auto/base.html#quickfort and
https://docs.dfhack.org/en/stable/docs/guides/quickfort-user-guide.html
]]
end

local action_switch = {
    set=quickfort_set.do_set,
    reset=quickfort_set.do_reset,
    gui=quickfort_dialog.do_dialog,
    list=quickfort_list.do_list,
    run=quickfort_command.do_command,
    orders=quickfort_command.do_command,
    undo=quickfort_command.do_command
}
setmetatable(action_switch, {__index=function() return print_short_help end})

local args = {...}
local action = table.remove(args, 1) or 'help'
args['action'] = action

action_switch[action](args)
