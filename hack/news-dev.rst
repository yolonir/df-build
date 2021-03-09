DFHack 0.47.05-r1
=================

Fixes
-----
- `confirm`: stopped exposing alternate names when convicting units
- `prospector`: improved pre embark rough estimates, particularly for small clusters

Misc Improvements
-----------------
- `autohauler`: allowed the ``Alchemist`` labor to be enabled in `manipulator` and other labor screens so it can be used for its intended purpose of flagging that no hauling labors should be assigned to a dwarf. Before, the only way to set the flag was to use an external program like Dwarf Therapist.
- `embark-assistant`: slightly improved performance of surveying
- `gui/no-dfhack-init`: clarified how to dismiss dialog that displays when no ``dfhack.init`` file is found
- `quickfort`:
    - Dreamfort blueprint set improvements: `significant <http://www.bay12forums.com/smf/index.php?topic=176889.msg8239017#msg8239017>`_ refinements across the entire blueprint set. Dreamfort is now much faster, much more efficient, and much easier to use. The `checklist <https://docs.google.com/spreadsheets/d/13PVZ2h3Mm3x_G1OXQvwKd7oIR2lK4A1Ahf6Om1kFigw/edit#gid=1459509569>`__ now includes a mini-walkthrough for quick reference. The spreadsheet now also includes `embark profile suggestions <https://docs.google.com/spreadsheets/d/13PVZ2h3Mm3x_G1OXQvwKd7oIR2lK4A1Ahf6Om1kFigw/edit#gid=149144025>`__
    - added aliases for configuring masterwork and artifact core quality for all stockpile categories that have them; made it possible to take from multiple stockpiles in the ``quantumstop`` alias
    - an active cursor is no longer required for running #notes blueprints (like the dreamfort walkthrough)
    - you can now be in any mode with an active cursor when running ``#query`` blueprints (before you could only be in a few "approved" modes, like look, query, or place)
    - refined ``#query`` blueprint sanity checks: cursor should still be on target tile at end of configuration, and it's ok for the screen ID to change if you are destroying (or canceling destruction of) a building
    - now reports how many work orders were added when generating manager orders from blueprints in the gui dialog
    - added ``--dry-run`` option to process blueprints but not change any game state
    - you can now specify the number of desired barrels, bins, and wheelbarrows for individual stockpiles when placing them
    - ``quickfort orders`` on a ``#place`` blueprint will now enqueue manager orders for barrels, bins, or wheelbarrows that are explicitly set in the blueprint.
    - you can now add alias definitions directly to your blueprint files instead of having to put them in a separate aliases.txt file. makes sharing blueprints with custom alias definitions much easier.

Structures
----------
- Identified scattered enum values (some rhythm beats, a couple of corruption unit thoughts, and a few language name categories)
- ``viewscreen_loadgamest``: renamed ``cur_step`` enumeration to match style of ``viewscreen_adopt_regionst`` and ``viewscreen_savegamest``
- ``viewscreen_savegamest``: identified ``cur_step`` enumeration

Documentation
-------------
- `digfort`: added deprecation warnings - digfort has been replaced by `quickfort`
- `fortplan`: added deprecation warnings - fortplan has been replaced by `quickfort`


DFHack 0.47.05-beta1
====================

Fixes
-----
- `embark-assistant`: fixed bug in soil depth determination for ocean tiles
- `orders`: don't crash when importing orders with malformed JSON
- `quickfort`: raw numeric `quickfort-dig-priorities` (e.g. ``3``, which is a valid shorthand for ``d3``) now works when used in .xlsx blueprints

Misc Improvements
-----------------
- `quickfort`: new commandline options for setting the initial state of the gui dialog. for example: ``quickfort gui -l dreamfort notes`` will start the dialog filtered for the dreamfort walkthrough blueprints

Structures
----------
- Dropped support for 0.47.03-0.47.04


DFHack 0.47.04-r5
=================

New Scripts
-----------
- `gui/quickfort`: fast access to the quickfort interactive dialog
- `workorder-recheck`: resets the selected work order to the ``Checking`` state

Fixes
-----
- `embark-assistant`:
    - fixed order of factors when calculating min temperature
    - improved performance of surveying
- `quickfort`:
    - fixed eventual crashes when creating zones
    - fixed library aliases for tallow and iron, copper, and steel weapons
    - zones are now created in the active state by default
    - solve rare crash when changing UI modes
- `search-plugin`: fixed crash when searching the ``k`` sidebar and navigating to another tile with certain keys, like ``<`` or ``>``
- `seedwatch`: fixed an issue where the plugin would disable itself on map load
- `stockflow`: fixed ``j`` character being intercepted when naming stockpiles
- `stockpiles`: no longer outputs hotkey help text beneath `stockflow` hotkey help text

Misc Improvements
-----------------
- Lua label widgets (used in all standard message boxes) are now scrollable with Up/Down/PgUp/PgDn keys
- `autofarm`: now fallows farms if all plants have reached the desired count
- `buildingplan`:
    - added ability to set global settings from the console, e.g.  ``buildingplan set boulders false``
    - added "enable all" option for buildingplan (so you don't have to enable all building types individually). This setting is not persisted (just like quickfort_mode is not persisted), but it can be set from onMapLoad.init
    - modified ``Planning Mode`` status in the UI to show whether the plugin is in quickfort mode, "enable all" mode, or whether just the building type is enabled.
- `quickfort`:
    - Dreamfort blueprint set improvements: added a streamlined checklist for all required dreamfort commands and gave names to stockpiles, levers, bridges, and zones
    - added aliases for bronze weapons and armor
    - added alias for tradeable crafts
    - new blueprint mode: ``#ignore``, useful for scratch space or personal notes
    - implement ``{Empty}`` keycode for use in quickfort aliases; useful for defining blank-by-default alias values
    - more flexible commandline parsing allowing for more natural parameter ordering (e.g. where you used to have to write ``quickfort list dreamfort -l`` you can now write ``quickfort list -l dreamfort``)
    - print out blueprint names that a ``#meta`` blueprint is applying so it's easier to understand what meta blueprints are doing
    - whitespace is now allowed between a marker name and the opening parenthesis in blueprint modelines. for example, ``#dig start (5; 5)`` is now valid (you used to be required to write ``#dig start(5; 5)``)

Lua
---
- ``dfhack.run_command()``: changed to interface directly with the console when possible, which allows interactive commands and commands that detect the console encoding to work properly
- ``processArgsGetopt()`` added to utils.lua, providing a callback interface for parameter parsing and getopt-like flexibility for parameter ordering and combination (see docs in ``library/lua/utils.lua`` and ``library/lua/3rdparty/alt_getopt.lua`` for details).

Structures
----------
- ``job``: identified ``order_id`` field

Documentation
-------------
- Added documentation for Lua's ``dfhack.run_command()`` and variants


DFHack 0.47.04-r4
=================

New Scripts
-----------
- `fix/corrupt-equipment`: fixes some military equipment-related corruption issues that can cause DF crashes

Fixes
-----
- Fixed an issue on some Linux systems where DFHack installed through a package manager would attempt to write files to a non-writable folder (notably when running `exportlegends` or `gui/autogems`)
- `adaptation`: fixed handling of units with no cave adaptation suffered yet
- `assign-goals`: fixed error preventing new goals from being created
- `assign-preferences`: fixed handling of preferences for flour
- `buildingplan`:
    - fixed an issue preventing artifacts from being matched when the maximum item quality is set to ``artifacts``
    - stopped erroneously matching items to buildings while the game is paused
    - fixed a crash when pressing 0 while having a noble room selected
- `deathcause`: fixed an error when inspecting certain corpses
- `dwarfmonitor`: fixed a crash when opening the ``prefs`` screen if units have vague preferences
- `dwarfvet`: fixed a crash that could occur when discharging patients
- `embark-assistant`:
    - fixed an issue causing incursion resource matching (e.g. sand/clay) to skip some tiles if those resources were provided only through incursions
    - corrected river size determination by performing it at the MLT level rather than the world tile level
- `quickfort`:
    - fixed handling of modifier keys (e.g. ``{Ctrl}`` or ``{Alt}``) in query blueprints
    - fixed misconfiguration of nest boxes, hives, and slabs that were preventing them from being built from build blueprints
    - fixed valid placement detection for floor hatches, floor grates, and floor bars (they were erroneously being rejected from open spaces and staircase tops)
    - fixed query blueprint statistics being added to the wrong metric when both a query and a zone blueprint are run by the same meta blueprint
    - added missing blueprint labels in gui dialog list
    - fixed occupancy settings for extent-based structures so that stockpiles can be placed within other stockpiles (e.g. in a checkerboard or bullseye pattern)
- `search-plugin`: fixed an issue where search options might not display if screens were destroyed and recreated programmatically (e.g. with `quickfort`)
- `unsuspend`: now leaves buildingplan-managed buildings alone and doesn't unsuspend underwater tasks
- `workflow`: fixed an error when creating constraints on "mill plants" jobs and some other plant-related jobs
- `zone`: fixed an issue causing the ``enumnick`` subcommand to run when attempting to run ``assign``, ``unassign``, or ``slaughter``

Misc Improvements
-----------------
- `buildingplan`:
    - added support for all buildings, furniture, and constructions (except for instruments)
    - added support for respecting building job_item filters when matching items, so you can set your own programmatic filters for buildings before submitting them to buildingplan
    - changed default filter setting for max quality from ``artifact`` to ``masterwork``
    - changed min quality adjustment hotkeys from 'qw' to 'QW' to avoid conflict with existing hotkeys for setting roller speed - also changed max quality adjustment hotkeys from 'QW' to 'AS' to make room for the min quality hotkey changes
    - added a new global settings page accessible via the ``G`` hotkey when on any building build screen; ``Quickfort Mode`` toggle for legacy Python Quickfort has been moved to this page
    - added new global settings for whether generic building materials should match blocks, boulders, logs, and/or bars - defaults are everything but bars
- `devel/export-dt-ini`: updated for Dwarf Therapist 41.2.0
- `embark-assistant`: split the lair types displayed on the local map into mound, burrow, and lair
- `gui/advfort`: added support for linking to hatches and pressure plates with mechanisms
- `modtools/add-syndrome`: added support for specifying syndrome IDs instead of names
- `probe`: added more output for designations and tile occupancy
- `quickfort`:
    - The Dreamfort sample blueprints now have complete walkthroughs for each fort level and importable orders that automate basic fort stock management
    - added more blueprints to the blueprints library: several bedroom layouts, the Saracen Crypts, and the complete fortress example from Python Quickfort: TheQuickFortress
    - query blueprint aliases can now accept parameters for dynamic expansion - see dfhack-config/quickfort/aliases.txt for details
    - alias names can now include dashes and underscores (in addition to letters and numbers)
    - improved speed of first call to ``quickfort list`` significantly, especially for large blueprint libraries
    - added ``query_unsafe`` setting to disable query blueprint error checking - useful for query blueprints that send unusual key sequences
    - added support for bookcases, display cases, and offering places (altars)
    - added configuration support for zone pit/pond, gather, and hospital sub-menus in zone blueprints
    - removed ``buildings_use_blocks`` setting and replaced it with more flexible functionality in `buildingplan`
    - added support for creating uninitialized stockpiles with :kbd:`c`

API
---
- `buildingplan`: added Lua interface API
- ``Buildings::setSize()``: changed to reuse existing extents when possible
- ``dfhack.job.isSuitableMaterial()``: added an item type parameter so the ``non_economic`` flag can be properly handled (it was being matched for all item types instead of just boulders)

Lua
---
- ``utils.addressof()``: fixed for raw userdata

Structures
----------
- ``building_extents_type``: new enum, used for ``building_extents.extents``
- ``world_mountain_peak``: new struct (was previously inline) - used in ``world_data.mountain_peaks``

Documentation
-------------
- `quickfort-alias-guide`: alias syntax and alias standard library documentation for `quickfort` blueprints
- `quickfort-library-guide`: overview of the quickfort blueprint library


DFHack 0.47.04-r3
=================

New Plugins
-----------
- `xlsxreader`: provides an API for Lua scripts to read Excel spreadsheets

New Scripts
-----------
- `quickfort`: DFHack-native implementation of quickfort with many new features and integrations - see the `quickfort-user-guide` for details
- `timestream`: controls the speed of the calendar and creatures
- `uniform-unstick`: prompts units to reevaluate their uniform, by removing/dropping potentially conflicting worn items

Fixes
-----
- `ban-cooking`: fixed an error in several subcommands
- `buildingplan`: fixed handling of buildings that require buckets
- `getplants`: fixed a crash that could occur on some maps
- `search-plugin`: fixed an issue causing item counts on the trade screen to display inconsistently when searching
- `stockpiles`:
    - fixed a crash when loading food stockpiles
    - fixed an error when saving furniture stockpiles

Misc Improvements
-----------------
- `createitem`:
    - added support for plant growths (fruit, berries, leaves, etc.)
    - added an ``inspect`` subcommand to print the item and material tokens of existing items, which can be used to create additional matching items
- `embark-assistant`: added support for searching for taller waterfalls (up to 50 z-levels tall)
- `search-plugin`: added support for searching for names containing non-ASCII characters using their ASCII equivalents
- `stocks`: added support for searching for items containing non-ASCII characters using their ASCII equivalents
- `unretire-anyone`: made undead creature names appear in the historical figure list
- `zone`:
    - added an ``enumnick`` subcommand to assign enumerated nicknames (e.g "Hen 1", "Hen 2"...)
    - added slaughter indication to ``uinfo`` output

API
---
- Added ``DFHack::to_search_normalized()`` (Lua: ``dfhack.toSearchNormalized()``) to convert non-ASCII alphabetic characters to their ASCII equivalents

Structures
----------
- ``history_event_masterpiece_createdst``: fixed alignment, including subclasses, and identified ``skill_at_time``
- ``item_body_component``: fixed some alignment issues and identified some fields (also applies to subclasses like ``item_corpsest``)
- ``stockpile_settings``: removed ``furniture.sand_bags`` (no longer present)

Documentation
-------------
- Fixed syntax highlighting of most code blocks to use the appropriate language (or no language) instead of Python


DFHack 0.47.04-r2
=================

New Scripts
-----------
- `animal-control`: helps manage the butchery and gelding of animals
- `devel/kill-hf`: kills a historical figure
- `geld`: gelds or ungelds animals
- `list-agreements`: lists all guildhall and temple agreements
- `list-waves`: displays migration wave information for citizens/units
- `ungeld`: ungelds animals (wrapper around `geld`)

New Tweaks
----------
- `tweak` do-job-now: adds a job priority toggle to the jobs list
- `tweak` reaction-gloves: adds an option to make reactions produce gloves in sets with correct handedness

Fixes
-----
- Fixed a segfault when attempting to start a headless session with a graphical PRINT_MODE setting
- Fixed an issue with the macOS launcher failing to un-quarantine some files
- Fixed ``Units::isEggLayer``, ``Units::isGrazer``, ``Units::isMilkable``, ``Units::isTrainableHunting``, ``Units::isTrainableWar``, and ``Units::isTamable`` ignoring the unit's caste
- Linux: fixed ``dfhack.getDFPath()`` (Lua) and ``Process::getPath()`` (C++) to always return the DF root path, even if the working directory has changed
- `digfort`:
    - fixed y-line tracking when .csv files contain lines with only commas
    - fixed an issue causing blueprints touching the southern or eastern edges of the map to be rejected (northern and western edges were already allowed). This allows blueprints that span the entire embark area.
- `embark-assistant`: fixed a couple of incursion handling bugs.
- `embark-skills`: fixed an issue with structures causing the ``points`` option to do nothing
- `exportlegends`:
    - fixed an issue where two different ``<reason>`` tags could be included in a ``<historical_event>``
    - stopped including some tags with ``-1`` values which don't provide useful information
- `getplants`: fixed issues causing plants to be collected even if they have no growths (or unripe growths)
- `gui/advfort`: fixed "operate pump" job
- `gui/load-screen`: fixed an issue causing longer timezones to be cut off
- `labormanager`:
    - fixed handling of new jobs in 0.47
    - fixed an issue preventing custom furnaces from being built
- `modtools/moddable-gods`:
    - fixed an error when creating the historical figure
    - removed unused ``-domain`` and ``-description`` arguments
    - made ``-depictedAs`` argument work
- `names`:
    - fixed an error preventing the script from working
    - fixed an issue causing renamed units to display their old name in legends mode and some other places
- `pref-adjust`: fixed some compatibility issues and a potential crash
- `RemoteFortressReader`:
    - fixed a couple crashes that could result from decoding invalid enum items (``site_realization_building_type`` and ``improvement_type``)
    - fixed an issue that could cause block coordinates to be incorrect
- `rendermax`: fixed a hang that could occur when enabling some renderers, notably on Linux
- `stonesense`:
    - fixed a crash when launching Stonesense
    - fixed some issues that could cause the splash screen to hang

Misc Improvements
-----------------
- Linux/macOS: Added console keybindings for deleting words (Alt+Backspace and Alt+d in most terminals)
- `add-recipe`:
    - added tool recipes (minecarts, wheelbarrows, stepladders, etc.)
    - added a command explanation or error message when entering an invalid command
- `armoks-blessing`: added adjustments to values and needs
- `blueprint`:
    - now writes blueprints to the ``blueprints/`` subfolder instead of the df root folder
    - now automatically creates folder trees when organizing blueprints into subfolders (e.g. ``blueprint 30 30 1 rooms/dining dig`` will create the file ``blueprints/rooms/dining-dig.csv``); previously it would fail if the ``blueprints/rooms/`` directory didn't already exist
- `confirm`: added a confirmation dialog for convicting dwarves of crimes
- `devel/query`: added many new query options
- `digfort`:
    - handled double quotes (") at the start of a string, allowing .csv files exported from spreadsheets to work without manual modification
    - documented that removing ramps, cutting trees, and gathering plants are indeed supported
    - added a ``force`` option to truncate blueprints if the full blueprint would extend off the edge of the map
- `dwarf-op`:
    - added ability to select dwarves based on migration wave
    - added ability to protect dwarves based on symbols in their custom professions
- `exportlegends`:
    - changed some flags to be represented by self-closing tags instead of true/false strings (e.g. ``<is_volcano/>``) - note that this may require changes to other XML-parsing utilities
    - changed some enum values from numbers to their string representations
    - added ability to save all files to a subfolder, named after the region folder and date by default
- `gui/advfort`: added support for specifying the entity used to determine available resources
- `gui/gm-editor`: added support for automatically following ref-targets when pressing the ``i`` key
- `manipulator`: added a new column option to display units' goals
- `modtools/moddable-gods`: added support for ``neuter`` gender
- `pref-adjust`:
    - added support for adjusting just the selected dwarf
    - added a new ``goth`` profile
- `remove-stress`: added a ``-value`` argument to enable setting stress level directly
- `workorder`: changed default frequency from "Daily" to "OneTime"

API
---
- Added ``Filesystem::mkdir_recursive``
- Extended ``Filesystem::listdir_recursive`` to optionally make returned filenames relative to the start directory
- ``Units``: added goal-related functions: ``getGoalType()``, ``getGoalName()``, ``isGoalAchieved()``

Internals
---------
- Added support for splitting scripts into multiple files in the ``scripts/internal`` folder without polluting the output of `ls`

Lua
---
- Added a ``ref_target`` field to primitive field references, corresponding to the ``ref-target`` XML attribute
- Made ``dfhack.units.getRaceNameById()``, ``dfhack.units.getRaceBabyNameById()``, and ``dfhack.units.getRaceChildNameById()`` available to Lua

Ruby
----
- Updated ``item_find`` and ``building_find`` to use centralized logic that works on more screens

Structures
----------
- Added a new ``<df-other-vectors-type>``, which allows ``world.*.other`` collections of vectors to use the correct subtypes for items
- ``creature_raw``: renamed ``gender`` to ``sex`` to match the field in ``unit``, which is more frequently used
- ``crime``: identified ``witnesses``, which contains the data held by the old field named ``reports``
- ``intrigue``: new type (split out from ``historical_figure_relationships``)
- ``items_other_id``: removed ``BAD``, and by extension, ``world.items.other.BAD``, which was overlapping with ``world.items.bad``
- ``job_type``: added job types new to 0.47
- ``plant_raw``: material_defs now contains arrays rather than loose fields
- ``pronoun_type``: new enum (previously documented in field comments)
- ``setup_character_info``: fixed a couple alignment issues (needed by `embark-skills`)
- ``ui_advmode_menu``: identified some new enum items

Documentation
-------------
- Added some new dev-facing pages, including dedicated pages about the remote API, memory research, and documentation
- Expanded the installation guide
- Made a couple theme adjustments


DFHack 0.47.04-r1
=================

Fixes
-----
- Fixed a crash in ``find()`` for some types when no world is loaded
- Fixed translation of certain types of in-game names
- `autogems`: fixed an issue with binned gems being ignored in linked stockpiles
- `catsplosion`: fixed error when handling races with only one caste (e.g. harpies)
- `exportlegends`: fixed error when exporting maps
- `spawnunit`: fixed an error when forwarding some arguments but not a location to `modtools/create-unit`
- `stocks`: fixed display of book titles
- `tweak` embark-profile-name: fixed handling of the native shift+space key

Misc Improvements
-----------------
- `exportlegends`:
    - made interaction export more robust and human-readable
    - removed empty ``<item_subtype>`` and ``<claims>`` tags
- `getplants`: added switches for designations for farming seeds and for max number designated per plant
- `manipulator`: added intrigue to displayed skills
- `modtools/create-unit`:
    - added ``-equip`` option to equip created units
    - added ``-skills`` option to give skills to units
    - added ``-profession`` and ``-customProfession`` options to adjust unit professions
- `search-plugin`: added support for the fortress mode justice screen
- ``dfhack.init-example``: enabled `autodump`

API
---
- Added ``Items::getBookTitle`` to get titles of books. Catches titles buried in improvements, unlike getDescription.

Lua
---
- ``pairs()`` now returns available class methods for DF types

Structures
----------
- Added globals: ``cur_rain``, ``cur_rain_counter``, ``cur_snow``, ``cur_snow_counter``, ``weathertimer``, ``jobvalue``, ``jobvalue_setter``, ``interactitem``, ``interactinvslot``, ``handleannounce``, ``preserveannounce``, ``updatelightstate``
- ``agreement_details_data_plot_sabotage``: new struct type, along with related ``agreement_details_type.PlotSabotage``
- ``architectural_element``: new enum
- ``battlefield``: new struct type
- ``breed``: new struct type
- ``creature_handler``: identified vmethods
- ``crime``: removed fields of ``reports`` that are no longer present
- ``dance_form``: identified most fields
- ``history_event_context``: identified fields
- ``identity_type``: new enum
- ``identity``: renamed ``civ`` to ``entity_id``, identified ``type``
- ``image_set``: new struct type
- ``interrogation_report``: new struct type
- ``itemdef_flags``: new enum, with ``GENERATED`` flag
- ``justification``: new enum
- ``lever_target_type``: identified ``LeverMechanism`` and ``TargetMechanism`` values
- ``musical_form``: identified fields, including some renames. Also identified fields in ``scale`` and ``rhythm``
- ``region_weather``: new struct type
- ``squad_order_cause_trouble_for_entityst``: identified fields
- ``unit_thought_type``: added several new thought types
- ``viewscreen_workquota_detailsst``: identified fields


DFHack 0.47.04-beta1
====================

New Scripts
-----------
- `color-schemes`: manages color schemes
- `devel/print-event`: prints the description of an event by ID or index
- `gui/color-schemes`: an in-game interface for `color-schemes`
- `light-aquifers-only`: changes heavy aquifers to light aquifers
- `on-new-fortress`: runs DFHack commands only in a new fortress
- `once-per-save`: runs DFHack commands unless already run in the current save
- `resurrect-adv`: brings your adventurer back to life
- `reveal-hidden-units`: exposes all sneaking units
- `workorder`: allows queuing manager jobs; smart about shear and milk creature jobs

Fixes
-----
- Fixed a crash when starting DFHack in headless mode with no terminal
- `devel/visualize-structure`: fixed padding detection for globals
- `exportlegends`:
    - added UTF-8 encoding and XML escaping for more fields
    - added checking for unhandled structures to avoid generating invalid XML
    - fixed missing fields in ``history_event_assume_identityst`` export
- `full-heal`:
    - when resurrected by specifying a corpse, units now appear at the location of the corpse rather than their location of death
    - resurrected units now have their tile occupancy set (and are placed in the prone position to facilitate this)

Misc Improvements
-----------------
- Added "bit" suffix to downloads (e.g. 64-bit)
- Tests:
    - moved from DF folder to hack/scripts folder, and disabled installation by default
    - made test runner script more flexible
- `devel/export-dt-ini`: updated some field names for DT for 0.47
- `devel/visualize-structure`: added human-readable lengths to containers
- `dfhack-run`: added color output support
- `embark-assistant`:
    - updated embark aquifer info to show all aquifer kinds present
    - added neighbor display, including kobolds (SKULKING) and necro tower count
    - updated aquifer search criteria to handle the new variation
    - added search criteria for embark initial tree cover
    - added search criteria for necro tower count, neighbor civ count, and specific neighbors. Should handle additional entities, but not tested
- `exportlegends`:
    - added evilness and force IDs to regions
    - added profession and weapon info to relevant entities
    - added support for many new history events in 0.47
    - added historical event relationships and supplementary data
- `full-heal`:
    - made resurrection produce a historical event viewable in Legends mode
    - made error messages more explanatory
- `install-info`: added DFHack build ID to report
- `modtools/create-item`: added ``-matchingGloves`` and ``-matchingShoes`` arguments
- `modtools/create-unit`:
    - added ``-duration`` argument to make the unit vanish after some time
    - added ``-locationRange`` argument to allow spawning in a random position within a defined area
    - added ``-locationType`` argument to specify the type of location to spawn in

Internals
---------
- Added separate changelogs in the scripts and df-structures repos
- Improved support for tagged unions, allowing tools to access union fields more safely
- Moved ``reversing`` scripts to df_misc repo

Structures
----------
- Added an XML schema for validating df-structures syntax
- Added ``divination_set_next_id`` and ``image_set_next_id`` globals
- ``activity_entry_type``: new enum type
- ``adventure_optionst``: identified many vmethods
- ``agreement_details``: identified most fields of most sub-structs
- ``artifact_claim``: identified several fields
- ``artifact_record``: identified several fields
- ``caste_raw_flags``: renamed and identified many flags to match information from Toady
- ``creature_raw_flags``: renamed and identified many flags to match information from Toady
- ``crime_type``: new enum type
- ``dfhack_room_quality_level``: added enum attributes for names of rooms of each quality
- ``entity_site_link_type``: new enum type
- ``export_map_type``: new enum type
- ``historical_entity.flags``: identified several flags
- ``historical_entity.relations``: renamed from ``unknown1b`` and identified several fields
- ``historical_figure.vague_relationships``: identified
- ``historical_figure_info.known_info``: renamed from ``secret``, identified some fields
- ``historical_figure``: renamed ``unit_id2`` to ``nemesis_id``
- ``history_event_circumstance_info``: new struct type (and changed several ``history_event`` subclasses to use this)
- ``history_event_reason_info``: new struct type (and changed several ``history_event`` subclasses to use this)
- ``honors_type``: identified several fields
- ``interaction_effect_create_itemst``: new struct type
- ``interaction_effect_summon_unitst``: new struct type
- ``item``: identified several vmethods
- ``layer_type``: new enum type
- ``plant.damage_flags``: added ``is_dead``
- ``plot_role_type``: new enum type
- ``plot_strategy_type``: new enum type
- ``relationship_event_supplement``: new struct type
- ``relationship_event``: new struct type
- ``specific_ref``: moved union data to ``data`` field
- ``ui_look_list``: moved union fields to ``data`` and renamed to match ``type`` enum
- ``ui_sidebar_menus.location``: added new profession-related fields, renamed and fixed types of deity-related fields
- ``ui_sidebar_mode``: added ``ZonesLocationInfo``
- ``unit_action``: rearranged as tagged union with new sub-types; existing code should be compatible
- ``vague_relationship_type``: new enum type
- ``vermin_flags``: identified ``is_roaming_colony``
- ``viewscreen_justicest``: identified interrogation-related fields
- ``world_data.field_battles``: identified and named several fields


DFHack 0.47.03-beta1
====================

New Scripts
-----------
- `devel/sc`: checks size of structures
- `devel/visualize-structure`: displays the raw memory of a structure

Fixes
-----
- `adv-max-skills`: fixed for 0.47
- `deep-embark`:
    - prevented running in non-fortress modes
    - ensured that only the newest wagon is deconstructed
- `full-heal`:
    - fixed issues with removing corpses
    - fixed resurrection for non-historical figures
- `modtools/create-unit`: added handling for arena tame setting
- `teleport`: fixed setting new tile occupancy

Misc Improvements
-----------------
- `deep-embark`:
    - improved support for using directly from the DFHack console
    - added a ``-clear`` option to cancel
- `exportlegends`:
    - added identity information
    - added creature raw names and flags
- `gui/prerelease-warning`: updated links and information about nightly builds
- `modtools/syndrome-trigger`: enabled simultaneous use of ``-synclass`` and ``-syndrome``
- `repeat`: added ``-list`` option

Structures
----------
- Dropped support for 0.44.12-0.47.02
- ``abstract_building_type``: added types (and subclasses) new to 0.47
- ``agreement_details_type``: added enum
- ``agreement_details``: added struct type (and many associated data types)
- ``agreement_party``: added struct type
- ``announcement_type``: added types new to 0.47
- ``artifact_claim_type``: added enum
- ``artifact_claim``: added struct type
- ``breath_attack_type``: added ``SHARP_ROCK``
- ``building_offering_placest``: new class
- ``building_type``: added ``OfferingPlace``
- ``caste_raw_flags``: renamed many items to match DF names
- ``creature_interaction_effect``: added subclasses new to 0.47
- ``creature_raw_flags``:
    - identified several more items
    - renamed many items to match DF names
- ``d_init``: added settings new to 0.47
- ``entity_name_type``: added ``MERCHANT_COMPANY``, ``CRAFT_GUILD``
- ``entity_position_responsibility``: added values new to 0.47
- ``fortress_type``: added enum
- ``general_ref_type``: added ``UNIT_INTERROGATEE``
- ``ghost_type``: added ``None`` value
- ``goal_type``: added goals types new to 0.47
- ``histfig_site_link``: added subclasses new to 0.47
- ``history_event_collection``: added subtypes new to 0.47
- ``history_event_context``: added lots of new fields
- ``history_event_reason``:
    - added captions for all items
    - added items new to 0.47
- ``history_event_type``: added types for events new to 0.47, as well as corresponding ``history_event`` subclasses (too many to list here)
- ``honors_type``: added struct type
- ``interaction_effect``: added subtypes new to 0.47
- ``interaction_source_experimentst``: added class type
- ``interaction_source_usage_hint``: added values new to 0.47
- ``interface_key``: added items for keys new to 0.47
- ``job_skill``: added ``INTRIGUE``, ``RIDING``
- ``lair_type``: added enum
- ``monument_type``: added enum
- ``next_global_id``: added enum
- ``poetic_form_action``: added ``Beseech``
- ``setup_character_info``: expanded significantly in 0.47
- ``text_system``: added layout for struct
- ``tile_occupancy``: added ``varied_heavy_aquifer``
- ``tool_uses``: added items: ``PLACE_OFFERING``, ``DIVINATION``, ``GAMES_OF_CHANCE``
- ``viewscreen_counterintelligencest``: new class (only layout identified so far)


DFHack 0.44.12-r3
=================

New Plugins
-----------
- `autoclothing`: automatically manage clothing work orders
- `autofarm`: replaces the previous Ruby script of the same name, with some fixes
- `map-render`: allows programmatically rendering sections of the map that are off-screen
- `tailor`: automatically manages keeping your dorfs clothed

New Scripts
-----------
- `assign-attributes`: changes the attributes of a unit
- `assign-beliefs`: changes the beliefs of a unit
- `assign-facets`: changes the facets (traits) of a unit
- `assign-goals`: changes the goals of a unit
- `assign-preferences`: changes the preferences of a unit
- `assign-profile`: sets a dwarf's characteristics according to a predefined profile
- `assign-skills`: changes the skills of a unit
- `combat-harden`: sets a unit's combat-hardened value to a given percent
- `deep-embark`: allows embarking underground
- `devel/find-twbt`: finds a TWBT-related offset needed by the new `map-render` plugin
- `dwarf-op`: optimizes dwarves for fort-mode work; makes managing labors easier
- `forget-dead-body`: removes emotions associated with seeing a dead body
- `gui/create-tree`: creates a tree at the selected tile
- `linger`: takes over your killer in adventure mode
- `modtools/create-tree`: creates a tree
- `modtools/pref-edit`: add, remove, or edit the preferences of a unit
- `modtools/set-belief`: changes the beliefs (values) of units
- `modtools/set-need`: sets and edits unit needs
- `modtools/set-personality`: changes the personality of units
- `modtools/spawn-liquid`: spawns water or lava at the specified coordinates
- `set-orientation`: edits a unit's orientation
- `unretire-anyone`: turns any historical figure into a playable adventurer

Fixes
-----
- Fixed a crash in the macOS/Linux console when the prompt was wider than the screen width
- Fixed inconsistent results from ``Units::isGay`` for asexual units
- Fixed some cases where Lua filtered lists would not properly intercept keys, potentially triggering other actions on the same screen
- `autofarm`:
    - fixed biome detection to properly determine crop assignments on surface farms
    - reimplemented as a C++ plugin to make proper biome detection possible
- `bodyswap`: fixed companion list not being updated often enough
- `cxxrandom`: removed some extraneous debug information
- `digfort`: now accounts for z-level changes when calculating maximum y dimension
- `embark-assistant`:
    - fixed bug causing crash on worlds without generated metals (as well as pruning vectors as originally intended).
    - fixed bug causing mineral matching to fail to cut off at the magma sea, reporting presence of things that aren't (like DF does currently).
    - fixed bug causing half of the river tiles not to be recognized.
    - added logic to detect some river tiles DF doesn't generate data for (but are definitely present).
- `eventful`: fixed invalid building ID in some building events
- `exportlegends`: now escapes special characters in names properly
- `getplants`: fixed designation of plants out of season (note that picked plants are still designated incorrectly)
- `gui/autogems`: fixed error when no world is loaded
- `gui/companion-order`:
    - fixed error when resetting group leaders
    - ``leave`` now properly removes companion links
- `gui/create-item`: fixed module support - can now be used from other scripts
- `gui/stamper`:
    - stopped "invert" from resetting the designation type
    - switched to using DF's designation keybindings instead of custom bindings
    - fixed some typos and text overlapping
- `modtools/create-unit`:
    - fixed an error associating historical entities with units
    - stopped recalculating health to avoid newly-created citizens triggering a "recover wounded" job
    - fixed units created in arena mode having blank names
    - fixed units created in arena mode having the wrong race and/or interaction effects applied after creating units manually in-game
    - stopped units from spawning with extra items or skills previously selected in the arena
    - stopped setting some unneeded flags that could result in glowing creature tiles
    - set units created in adventure mode to have no family, instead of being related to the first creature in the world
- `modtools/reaction-product-trigger`:
    - fixed an error dealing with reactions in adventure mode
    - blocked ``\\BUILDING_ID`` for adventure mode reactions
    - fixed ``-clear`` to work without passing other unneeded arguments
- `modtools/reaction-trigger`:
    - fixed a bug when determining whether a command was run
    - fixed handling of ``-resetPolicy``
- `mousequery`: fixed calculation of map dimensions, which was sometimes preventing scrolling the map with the mouse when TWBT was enabled
- `RemoteFortressReader`: fixed a crash when a unit's path has a length of 0
- `stonesense`: fixed crash due to wagons and other soul-less creatures
- `tame`: now sets the civ ID of tamed animals (fixes compatibility with `autobutcher`)
- `title-folder`: silenced error when ``PRINT_MODE`` is set to ``TEXT``

Misc Improvements
-----------------
- Added a note to `dfhack-run` when called with no arguments (which is usually unintentional)
- On macOS, the launcher now attempts to un-quarantine the rest of DFHack
- `bodyswap`: added arena mode support
- `combine-drinks`: added more default output, similar to `combine-plants`
- `createitem`: added a list of valid castes to the "invalid caste" error message, for convenience
- `devel/export-dt-ini`: added more size information needed by newer Dwarf Therapist versions
- `dwarfmonitor`: enabled widgets to access other scripts and plugins by switching to the core Lua context
- `embark-assistant`:
    - added an in-game option to activate on the embark screen
    - changed waterfall detection to look for level drop rather than just presence
    - changed matching to take incursions, i.e. parts of other biomes, into consideration when evaluating tiles. This allows for e.g. finding multiple biomes on single tile embarks.
    - changed overlay display to show when incursion surveying is incomplete
    - changed overlay display to show evil weather
    - added optional parameter "fileresult" for crude external harness automated match support
    - improved focus movement logic to go to only required world tiles, increasing speed of subsequent searches considerably
- `exportlegends`: added rivers to custom XML export
- `exterminate`: added support for a special ``enemy`` caste
- `gui/gm-unit`:
    - added support for editing:
    - added attribute editor
    - added orientation editor
    - added editor for bodies and body parts
    - added color editor
    - added belief editor
    - added personality editor
- `modtools/create-item`: documented already-existing ``-quality`` option
- `modtools/create-unit`:
    - added the ability to specify ``\\LOCAL`` for the fort group entity
    - now enables the default labours for adult units with CAN_LEARN.
    - now sets historical figure orientation.
    - improved speed of creating multiple units at once
    - made the script usable as a module (from other scripts)
- `modtools/reaction-trigger`:
    - added ``-ignoreWorker``: ignores the worker when selecting the targets
    - changed the default behavior to skip inactive/dead units; added ``-dontSkipInactive`` to include creatures that are inactive
    - added ``-range``: controls how far elligible targets can be from the workshop
    - syndromes now are applied before commands are run, not after
    - if both a command and a syndrome are given, the command only runs if the syndrome could be applied
- `mousequery`: made it more clear when features are enabled
- `RemoteFortressReader`:
    - added a basic framework for controlling and reading the menus in DF (currently only supports the building menu)
    - added support for reading item raws
    - added a check for whether or not the game is currently saving or loading, for utilities to check if it's safe to read from DF
    - added unit facing direction estimate and position within tiles
    - added unit age
    - added unit wounds
    - added tree information
    - added check for units' current jobs when calculating the direction they are facing

API
---
- Added new ``plugin_load_data`` and ``plugin_save_data`` events for plugins to load/save persistent data
- Added ``Maps::GetBiomeType`` and ``Maps::GetBiomeTypeByRef`` to infer biome types properly
- Added ``Units::getPhysicalDescription`` (note that this depends on the ``unit_get_physical_description`` offset, which is not yet available for all DF builds)

Internals
---------
- Added new Persistence module
- Cut down on internal DFHack dependencies to improve build times
- Improved concurrency in event and server handlers
- Persistent data is now stored in JSON files instead of historical figures - existing data will be migrated when saving
- `stonesense`: fixed some OpenGL build issues on Linux

Lua
---
- Exposed ``gui.dwarfmode.get_movement_delta`` and ``gui.dwarfmode.get_hotkey_target``
- ``dfhack.run_command`` now returns the command's return code

Ruby
----
- Made ``unit_ishostile`` consistently return a boolean

Structures
----------
- Added ``unit_get_physical_description`` function offset on some platforms
- Added/identified types:
    - ``assume_identity_mode``
    - ``musical_form_purpose``
    - ``musical_form_style``
    - ``musical_form_pitch_style``
    - ``musical_form_feature``
    - ``musical_form_vocals``
    - ``musical_form_melodies``
    - ``musical_form_interval``
    - ``unit_emotion_memory``
- ``need_type``: fixed ``PrayOrMeditate`` typo
- ``personality_facet_type``, ``value_type``: added ``NONE`` values
- ``twbt_render_map``: added for 64-bit 0.44.12 (for `map-render`)


DFHack 0.44.12-r2
=================

New Plugins
-----------
- `debug`: manages runtime debug print category filtering
- `nestboxes`: automatically scan for and forbid fertile eggs incubating in a nestbox

New Scripts
-----------
- `devel/query`: searches for field names in DF objects
- `extinguish`: puts out fires
- `tame`: sets tamed/trained status of animals

Fixes
-----
- `building-hacks`: fixed error when dealing with custom animation tables
- `devel/test-perlin`: fixed Lua error (``math.pow()``)
- `embark-assistant`: fixed crash when entering finder with a 16x16 embark selected, and added 16 to dimension choices
- `embark-skills`: fixed missing ``skill_points_remaining`` field
- `full-heal`:
    - stopped wagon resurrection
    - fixed a minor issue with post-resurrection hostility
- `gui/companion-order`:
    - fixed issues with printing coordinates
    - fixed issues with move command
    - fixed cheat commands (and removed "Power up", which was broken)
- `gui/gm-editor`: fixed reinterpret cast (``r``)
- `gui/pathable`: fixed error when sidebar is hidden with ``Tab``
- `labormanager`:
    - stopped assigning labors to ineligible dwarves, pets, etc.
    - stopped assigning invalid labors
    - added support for crafting jobs that use pearl
    - fixed issues causing cleaning jobs to not be assigned
    - added support for disabling management of specific labors
- `prospector`: (also affected `embark-tools`) - fixed a crash when prospecting an unusable site (ocean, mountains, etc.) with a large default embark size in d_init.txt (e.g. 16x16)
- `siege-engine`: fixed a few Lua errors (``math.pow()``, ``unit.relationship_ids``)
- `tweak`: fixed ``hotkey-clear``

Misc Improvements
-----------------
- `armoks-blessing`: improved documentation to list all available arguments
- `devel/export-dt-ini`:
    - added viewscreen offsets for DT 40.1.2
    - added item base flags offset
    - added needs offsets
- `embark-assistant`:
    - added match indicator display on the right ("World") map
    - changed 'c'ancel to abort find if it's under way and clear results if not, allowing use of partial surveys.
    - added Coal as a search criterion, as well as a coal indication as current embark selection info.
- `full-heal`:
    - added ``-all``, ``-all_civ`` and ``-all_citizens`` arguments
    - added module support
    - now removes historical figure death dates and ghost data
- `growcrops`: added ``all`` argument to grow all crops
- `gui/load-screen`: improved documentation
- `labormanager`: now takes nature value into account when assigning jobs
- `open-legends`: added warning about risk of save corruption and improved related documentation
- `points`: added support when in ``viewscreen_setupdwarfgamest`` and improved error messages
- `siren`: removed break handling (relevant ``misc_trait_type`` was no longer used - see "Structures" section)

API
---
- New debug features related to `debug` plugin:
    - Classes (C++ only): ``Signal<Signature, type_tag>``, ``DebugCategory``, ``DebugManager``
    - Macros: ``TRACE``, ``DEBUG``, ``INFO``, ``WARN``, ``ERR``, ``DBG_DECLARE``, ``DBG_EXTERN``

Internals
---------
- Added a usable unit test framework for basic tests, and a few basic tests
- Added ``CMakeSettings.json`` with intellisense support
- Changed ``plugins/CMakeLists.custom.txt`` to be ignored by git and created (if needed) at build time instead
- Core: various thread safety and memory management improvements
- Fixed CMake build dependencies for generated header files
- Fixed custom ``CMAKE_CXX_FLAGS`` not being passed to plugins
- Linux/macOS: changed recommended build backend from Make to Ninja (Make builds will be significantly slower now)

Lua
---
- ``utils``: new ``OrderedTable`` class

Structures
----------
- Win32: added missing vtables for ``viewscreen_storesst`` and ``squad_order_rescue_hfst``
- ``activity_event_performancest``: renamed poem as written_content_id
- ``body_part_status``: identified ``gelded``
- ``dance_form``: named musical_form_id and musical_written_content_id
- ``incident_sub6_performance.participants``: named performance_event and role_index
- ``incident_sub6_performance``:
    - made performance_event an enum
    - named poetic_form_id, musical_form_id, and dance_form_id
- ``misc_trait_type``: removed ``LikesOutdoors``, ``Hardened``, ``TimeSinceBreak``, ``OnBreak`` (all unused by DF)
- ``musical_form_instruments``: named minimum_required and maximum_permitted
- ``musical_form``: named voices field
- ``plant_tree_info``: identified ``extent_east``, etc.
- ``plant_tree_tile``: gave connection bits more meaningful names (e.g. ``connection_east`` instead of ``thick_branches_1``)
- ``poetic_form``: identified many fields and related enum/bitfield types
- ``setup_character_info``: identified ``skill_points_remaining`` (for `embark-skills`)
- ``ui.main``: identified ``fortress_site``
- ``ui.squads``: identified ``kill_rect_targets_scroll``
- ``ui``: fixed alignment of ``main`` and ``squads`` (fixes `tweak` hotkey-clear and DF-AI)
- ``unit_action.attack``:
    - identified ``attack_skill``
    - added ``lightly_tap`` and ``spar_report`` flags
- ``unit_flags3``: identified ``marked_for_gelding``
- ``unit_personality``: identified ``stress_drain``, ``stress_boost``, ``likes_outdoors``, ``combat_hardened``
- ``unit_storage_status``: newly identified type, stores noble holdings information (used in ``viewscreen_layer_noblelistst``)
- ``unit_thought_type``: added new expulsion thoughts from 0.44.12
- ``viewscreen_layer_arena_creaturest``: identified item- and name-related fields
- ``viewscreen_layer_militaryst``: identified ``equip.assigned.assigned_items``
- ``viewscreen_layer_noblelistst``: identified ``storage_status`` (see ``unit_storage_status`` type)
- ``viewscreen_new_regionst``:
    - identified ``rejection_msg``, ``raw_folder``, ``load_world_params``
    - changed many ``int8_t`` fields to ``bool``
- ``viewscreen_setupadventurest``: identified some nemesis and personality fields, and ``page.ChooseHistfig``
- ``world_data``: added ``mountain_peak_flags`` type, including ``is_volcano``
- ``world_history``: identified names and/or types of some fields
- ``world_site``: identified names and/or types of some fields
- ``written_content``: named poetic_form


DFHack 0.44.12-r1
=================

Fixes
-----
- Console: fixed crash when entering long commands on Linux/macOS
- Fixed special characters in `command-prompt` and other non-console in-game outputs on Linux/macOS (in tools using ``df2console``)
- Removed jsoncpp's ``include`` and ``lib`` folders from DFHack builds/packages
- `die`: fixed Windows crash in exit handling
- `dwarfmonitor`, `manipulator`: fixed stress cutoffs
- `modtools/force`: fixed a bug where the help text would always be displayed and nothing useful would happen
- `ruby`: fixed calling conventions for vmethods that return strings (currently ``enabler.GetKeyDisplay()``)
- `startdwarf`: fixed on 64-bit Linux

Misc Improvements
-----------------
- Reduced time for designation jobs from tools like `digv` to be assigned workers
- `embark-assistant`:
    - Switched to standard scrolling keys, improved spacing slightly
    - Introduced scrolling of Finder search criteria, removing requirement for 46 lines to work properly (Help/Info still formatted for 46 lines).
    - Added Freezing search criterion, allowing searches for NA/Frozen/At_Least_Partial/Partial/At_Most_Partial/Never Freezing embarks.
- `rejuvenate`:
    - Added ``-all`` argument to apply to all citizens
    - Added ``-force`` to include units under 20 years old
    - Clarified documentation

API
---
- Added to ``Units`` module:
    - ``getStressCategory(unit)``
    - ``getStressCategoryRaw(level)``
    - ``stress_cutoffs`` (Lua: ``getStressCutoffs()``)

Internals
---------
- Added documentation for all RPC functions and a build-time check
- Added support for build IDs to development builds
- Changed default build architecture to 64-bit
- Use ``dlsym(3)`` to find vtables from libgraphics.so

Structures
----------
- Added ``start_dwarf_count`` on 64-bit Linux again and fixed scanning script
- ``army_controller``: added new vector from 0.44.11
- ``belief_system``: new type, few fields identified
- ``mental_picture``: new type, some fields identified
- ``mission_report``:
    - new type (renamed, was ``mission`` before)
    - identified some fields
- ``mission``: new type (used in ``viewscreen_civlistst``)
- ``spoils_report``: new type, most fields identified
- ``viewscreen_civlistst``:
    - split ``unk_20`` into 3 pointers
    - identified new pages
    - identified new messenger-related fields
- ``viewscreen_image_creatorst``:
    - fixed layout
    - identified many fields
- ``viewscreen_reportlistst``: added new mission and spoils report-related fields (fixed layout)
- ``world.languages``: identified (minimal information; whole languages stored elsewhere)
- ``world.status``:
    - ``mission_reports``: renamed, was ``missions``
    - ``spoils_reports``: identified
- ``world.unk_131ec0``, ``world.unk_131ef0``: researched layout
- ``world.worldgen_status``: identified many fields
- ``world``: ``belief_systems``: identified


DFHack 0.44.12-alpha1
=====================

Fixes
-----
- macOS: fixed ``renderer`` vtable address on x64 (fixes `rendermax`)
- `stonesense`: fixed ``PLANT:DESERT_LIME:LEAF`` typo

API
---
- Added C++-style linked list interface for DF linked lists

Structures
----------
- Dropped 0.44.11 support
- ``ui.squads``: Added fields new in 0.44.12


DFHack 0.44.11-beta2.1
======================

Internals
---------
- `stonesense`: fixed build


DFHack 0.44.11-beta2
====================

Fixes
-----
- Windows: Fixed console failing to initialize
- `command-prompt`: added support for commands that require a specific screen to be visible, e.g. `spotclean`
- `gui/workflow`: fixed advanced constraint menu for crafts

API
---
- Added ``Screen::Hide`` to temporarily hide screens, like `command-prompt`


DFHack 0.44.11-beta1
====================

Fixes
-----
- Fixed displayed names (from ``Units::getVisibleName``) for units with identities
- Fixed potential memory leak in ``Screen::show()``
- `fix/dead-units`: fixed script trying to use missing isDiplomat function

Misc Improvements
-----------------
- Console:
    - added support for multibyte characters on Linux/macOS
    - made the console exit properly when an interactive command is active (`liquids`, `mode`, `tiletypes`)
- Linux: added automatic support for GCC sanitizers in ``dfhack`` script
- Made the ``DFHACK_PORT`` environment variable take priority over ``remote-server.json``
- `dfhack-run`: added support for port specified in ``remote-server.json``, to match DFHack's behavior
- `digfort`: added better map bounds checking
- `remove-stress`:
    - added support for ``-all`` as an alternative to the existing ``all`` argument for consistency
    - sped up significantly
    - improved output/error messages
    - now removes tantrums, depression, and obliviousness
- `ruby`: sped up handling of onupdate events

API
---
- Exposed ``Screen::zoom()`` to C++ (was Lua-only)
- New functions: ``Units::isDiplomat(unit)``

Internals
---------
- jsoncpp: updated to version 1.8.4 and switched to using a git submodule

Lua
---
- Added ``printall_recurse`` to print tables and DF references recursively. It can be also used with ``^`` from the `lua` interpreter.
- ``gui.widgets``: ``List:setChoices`` clones ``choices`` for internal table changes

Structures
----------
- ``history_event_entity_expels_hfst``: added (new in 0.44.11)
- ``history_event_site_surrenderedst``: added (new in 0.44.11)
- ``history_event_type``: added ``SITE_SURRENDERED``, ``ENTITY_EXPELS_HF`` (new in 0.44.11)
- ``syndrome``: identified a few fields
- ``viewscreen_civlistst``: fixed layout and identified many fields


DFHack 0.44.11-alpha1
=====================

Structures
----------
- Added support for automatically sizing arrays indexed with an enum
- Dropped 0.44.10 support
- Removed stale generated CSV files and DT layouts from pre-0.43.05
- ``announcement_type``: new in 0.44.11: ``NEW_HOLDING``, ``NEW_MARKET_LINK``
- ``breath_attack_type``: added ``OTHER``
- ``historical_figure_info.relationships.list``: added ``unk_3a``-``unk_3c`` fields at end
- ``interface_key``: added bindings new in 0.44.11
- ``occupation_type``: new in 0.44.11: ``MESSENGER``
- ``profession``: new in 0.44.11: ``MESSENGER``
- ``ui_sidebar_menus``:
    - ``unit.in_squad``: renamed to ``unit.squad_list_opened``, fixed location
    - ``unit``: added ``expel_error`` and other unknown fields new in 0.44.11
    - ``hospital``: added, new in 0.44.11
    - ``num_speech_tokens``, ``unk_17d8``: moved out of ``command_line`` to fix layout on x64
- ``viewscreen_civlistst``: added a few new fields (incomplete)
- ``viewscreen_locationsst``: identified ``edit_input``


DFHack 0.44.10-r2
=================

New Plugins
-----------
- `cxxrandom`: exposes some features of the C++11 random number library to Lua

New Scripts
-----------
- `add-recipe`: adds unknown crafting recipes to the player's civ
- `gui/stamper`: allows manipulation of designations by transforms such as translations, reflections, rotations, and inversion

Fixes
-----
- Fixed many tools incorrectly using the ``dead`` unit flag (they should generally check ``flags2.killed`` instead)
- Fixed many tools passing incorrect arguments to printf-style functions, including a few possible crashes (`changelayer`, `follow`, `forceequip`, `generated-creature-renamer`)
- Fixed several bugs in Lua scripts found by static analysis (df-luacheck)
- Fixed ``-g`` flag (GDB) in Linux ``dfhack`` script (particularly on x64)
- `autochop`, `autodump`, `autogems`, `automelt`, `autotrade`, `buildingplan`, `dwarfmonitor`, `fix-unit-occupancy`, `fortplan`, `stockflow`: fix issues with periodic tasks not working for some time after save/load cycles
- `autogems`:
    - stop running repeatedly when paused
    - fixed crash when furnaces are linked to same stockpiles as jeweler's workshops
- `autogems`, `fix-unit-occupancy`: stopped running when a fort isn't loaded (e.g. while embarking)
- `autounsuspend`: now skips planned buildings
- `ban-cooking`: fixed errors introduced by kitchen structure changes in 0.44.10-r1
- `buildingplan`, `fortplan`: stopped running before a world has fully loaded
- `deramp`: fixed deramp to find designations that already have jobs posted
- `dig`: fixed "Inappropriate dig square" announcements if digging job has been posted
- `fixnaked`: fixed errors due to emotion changes in 0.44
- `remove-stress`: fixed an error when running on soul-less units (e.g. with ``-all``)
- `revflood`: stopped revealing tiles adjacent to tiles above open space inappropriately
- `stockpiles`: ``loadstock`` now sets usable and unusable weapon and armor settings
- `stocks`: stopped listing carried items under stockpiles where they were picked up from

Misc Improvements
-----------------
- Added script name to messages produced by ``qerror()`` in Lua scripts
- Fixed an issue in around 30 scripts that could prevent edits to the files (adding valid arguments) from taking effect
- Linux: Added several new options to ``dfhack`` script: ``--remotegdb``, ``--gdbserver``, ``--strace``
- `bodyswap`: improved error handling
- `buildingplan`: added max quality setting
- `caravan`: documented (new in 0.44.10-alpha1)
- `deathcause`: added "slaughtered" to descriptions
- `embark-assistant`:
    - changed region interaction matching to search for evil rain, syndrome rain, and reanimation rather than interaction presence (misleadingly called evil weather), reanimation, and thralling
    - gave syndrome rain and reanimation wider ranges of criterion values
- `fix/dead-units`: added a delay of around 1 month before removing units
- `fix/retrieve-units`: now re-adds units to active list to counteract `fix/dead-units`
- `item-descriptions`: fixed several grammatical errors
- `modtools/create-unit`:
    - added quantity argument
    - now selects a caste at random if none is specified
- `mousequery`:
    - migrated several features from TWBT's fork
    - added ability to drag with left/right buttons
    - added depth display for TWBT (when multilevel is enabled)
    - made shift+click jump to lower levels visible with TWBT
- `title-version`: added version to options screen too

API
---
- New functions (also exposed to Lua):
    - ``Units::isKilled()``
    - ``Units::isActive()``
    - ``Units::isGhost()``
- Removed Vermin module (unused and obsolete)

Internals
---------
- Added build option to generate symbols for large generated files containing df-structures metadata
- Added fallback for YouCompleteMe database lookup failures (e.g. for newly-created files)
- Improved efficiency and error handling in ``stl_vsprintf`` and related functions
- jsoncpp: fixed constructor with ``long`` on Linux

Lua
---
- Added ``profiler`` module to measure lua performance
- Enabled shift+cursor movement in WorkshopOverlay-derived screens

Structures
----------
- ``incident_sub6_performance``: identified some fields
- ``item_body_component``: fixed location of ``corpse_flags``
- ``job_handler``: fixed static array layout
- ``job_type``: added ``is_designation`` attribute
- ``unit_flags1``: renamed ``dead`` to ``inactive`` to better reflect its use
- ``unit_personality``: fixed location of ``current_focus`` and ``undistracted_focus``
- ``unit_thought_type``: added ``SawDeadBody`` (new in 0.44.10)


DFHack 0.44.10-r1
=================

New Scripts
-----------
- `bodyswap`: shifts player control over to another unit in adventure mode

New Tweaks
----------
- `tweak` kitchen-prefs-all: adds an option to toggle cook/brew for all visible items in kitchen preferences
- `tweak` stone-status-all: adds an option to toggle the economic status of all stones

Fixes
-----
- Lua: registered ``dfhack.constructions.designateRemove()`` correctly
- `prospector`: fixed crash due to invalid vein materials
- `tweak` max-wheelbarrow: fixed conflict with building renaming
- `view-item-info`: stopped appending extra newlines permanently to descriptions

Misc Improvements
-----------------
- Added logo to documentation
- Documented several missing ``dfhack.gui`` Lua functions
- `adv-rumors`: bound to Ctrl-A
- `command-prompt`: added support for ``Gui::getSelectedPlant()``
- `gui/advfort`: bound to Ctrl-T
- `gui/room-list`: added support for ``Gui::getSelectedBuilding()``
- `gui/unit-info-viewer`: bound to Alt-I
- `modtools/create-unit`: made functions available to other scripts
- `search-plugin`:
    - added support for stone restrictions screen (under ``z``: Status)
    - added support for kitchen preferences (also under ``z``)

API
---
- New functions (all available to Lua as well):
    - ``Buildings::getRoomDescription()``
    - ``Items::checkMandates()``
    - ``Items::canTrade()``
    - ``Items::canTradeWithContents()``
    - ``Items::isRouteVehicle()``
    - ``Items::isSquadEquipment()``
    - ``Kitchen::addExclusion()``
    - ``Kitchen::findExclusion()``
    - ``Kitchen::removeExclusion()``
- syndrome-util: added ``eraseSyndromeData()``

Internals
---------
- Fixed compiler warnings on all supported build configurations
- Windows build scripts now work with non-C system drives

Structures
----------
- ``dfhack_room_quality_level``: new enum
- ``glowing_barrier``: identified ``triggered``, added comments
- ``item_flags2``: renamed ``has_written_content`` to ``unk_book``
- ``kitchen_exc_type``: new enum (for ``ui.kitchen``)
- ``mandate.mode``: now an enum
- ``unit_personality.emotions.flags.memory``: identified
- ``viewscreen_kitchenprefst.forbidden``, ``possible``: now a bitfield, ``kitchen_pref_flag``
- ``world_data.feature_map``: added extensive documentation (in XML)


DFHack 0.44.10-beta1
====================

New Scripts
-----------
- `devel/find-primitive`: finds a primitive variable in memory

Fixes
-----
- Units::getAnyUnit(): fixed a couple problematic conditions and potential segfaults if global addresses are missing
- `autodump`, `automelt`, `autotrade`, `stocks`, `stockpiles`: fixed conflict with building renaming
- `exterminate`: fixed documentation of ``this`` option
- `full-heal`:
    - units no longer have a tendency to melt after being healed
    - healed units are no longer treated as patients by hospital staff
    - healed units no longer attempt to clean themselves unsuccessfully
    - wounded fliers now regain the ability to fly upon being healing
    - now heals suffocation, numbness, infection, spilled guts and gelding
- `modtools/create-unit`:
    - creatures of the appropriate age are now spawned as babies or children where applicable
    - fix: civ_id is now properly assigned to historical_figure, resolving several hostility issues (spawned pets are no longer attacked by fortress military!)
    - fix: unnamed creatures are no longer spawned with a string of numbers as a first name
- `stockpiles`: stopped sidebar option from overlapping with `autodump`
- `tweak` block-labors: fixed two causes of crashes related in the v-p-l menu

Misc Improvements
-----------------
- `blueprint`: added a basic Lua API
- `devel/export-dt-ini`: added tool offsets for DT 40
- `devel/save-version`: added current DF version to output
- `install-info`: added information on tweaks

Internals
---------
- Added function names to DFHack's NullPointer and InvalidArgument exceptions
- Added ``Gui::inRenameBuilding()``
- Linux: required plugins to have symbols resolved at link time, for consistency with other platforms


DFHack 0.44.10-alpha1
=====================

New Scripts
-----------
- `caravan`: adjusts properties of caravans
- `gui/autogems`: a configuration UI for the `autogems` plugin

Fixes
-----
- Fixed uninitialized pointer being returned from ``Gui::getAnyUnit()`` in rare cases
- `autohauler`, `autolabor`, `labormanager`: fixed fencepost error and potential crash
- `dwarfvet`: fixed infinite loop if an animal is not accepted at a hospital
- `liquids`: fixed "range" command to default to 1 for dimensions consistently
- `search-plugin`: fixed 4/6 keys in unit screen search
- `view-item-info`: fixed an error with some armor

Misc Improvements
-----------------
- `autogems`: can now blacklist arbitrary gem types (see `gui/autogems`)
- `exterminate`: added more words for current unit, removed warning
- `fpause`: now pauses worldgen as well

Internals
---------
- Added some build scripts for Sublime Text
- Changed submodule URLs to relative URLs so that they can be cloned consistently over different protocols (e.g. SSH)


DFHack 0.44.09-r1
=================

Fixes
-----
- `modtools/item-trigger`: fixed token format in help text

Misc Improvements
-----------------
- Reorganized changelogs and improved changelog editing process
- `modtools/item-trigger`: added support for multiple type/material/contaminant conditions

Internals
---------
- OS X: Can now build with GCC 7 (or older)

Structures
----------
- ``army``: added vector new in 0.44.07
- ``building_type``: added human-readable ``name`` attribute
- ``furnace_type``: added human-readable ``name`` attribute
- ``renderer``: fixed vtable addresses on 64-bit OS X
- ``site_reputation_report``: named ``reports`` vector
- ``workshop_type``: added human-readable ``name`` attribute


DFHack 0.44.09-alpha1
=====================

Fixes
-----
- `digtype`: stopped designating non-vein tiles (open space, trees, etc.)
- `labormanager`: fixed crash due to dig jobs targeting some unrevealed map blocks


DFHack 0.44.08-alpha1
=====================

Fixes
-----
- `fix/dead-units`: fixed a bug that could remove some arriving (not dead) units


DFHack 0.44.07-beta1
====================

Misc Improvements
-----------------
- `modtools/item-trigger`: added the ability to specify inventory mode(s) to trigger on

Structures
----------
- Added symbols for Toady's `0.44.07 Linux test build <http://www.bay12forums.com/smf/index.php?topic=169839.msg7720111#msg7720111>`_ to fix :bug:`10615`
- ``world_site``: fixed alignment


DFHack 0.44.07-alpha1
=====================

Fixes
-----
- Fixed some CMake warnings (CMP0022)
- Support for building on Ubuntu 18.04
- `embark-assistant`: fixed detection of reanimating biomes

Misc Improvements
-----------------
- `embark-assistant`:
    - Added search for adamantine
    - Now supports saving/loading profiles
- `fillneeds`: added ``-all`` option to apply to all units
- `remotefortressreader`: added flows, instruments, tool names, campfires, ocean waves, spiderwebs

Structures
----------
- Several new names in instrument raw structures
- ``identity``: identified ``profession``, ``civ``
- ``manager_order_template``: fixed last field type
- ``viewscreen_createquotast``: fixed layout
- ``world.language``: moved ``colors``, ``shapes``, ``patterns`` to ``world.descriptors``
- ``world.reactions``, ``world.reaction_categories``: moved to new compound, ``world.reactions``. Requires renaming:
    - ``world.reactions`` to ``world.reactions.reactions``
    - ``world.reaction_categories`` to ``world.reactions.reaction_categories``


DFHack 0.44.05-r2
=================

New Plugins
-----------
- `embark-assistant`: adds more information and features to embark screen

New Scripts
-----------
- `adv-fix-sleepers`: fixes units in adventure mode who refuse to wake up (:bug:`6798`)
- `hermit`: blocks caravans, migrants, diplomats (for hermit challenge)

New Features
------------
- With ``PRINT_MODE:TEXT``, setting the ``DFHACK_HEADLESS`` environment variable will hide DF's display and allow the console to be used normally. (Note that this is intended for testing and is not very useful for actual gameplay.)

Fixes
-----
- `devel/export-dt-ini`: fix language_name offsets for DT 39.2+
- `devel/inject-raws`: fixed gloves and shoes (old typo causing errors)
- `remotefortressreader`: fixed an issue with not all engravings being included
- `view-item-info`: fixed an error with some shields

Misc Improvements
-----------------
- `adv-rumors`: added more keywords, including names
- `autochop`: can now exclude trees that produce fruit, food, or cookable items
- `remotefortressreader`: added plant type support


DFHack 0.44.05-r1
=================

New Scripts
-----------
- `break-dance`: Breaks up a stuck dance activity
- `fillneeds`: Use with a unit selected to make them focused and unstressed
- `firestarter`: Lights things on fire: items, locations, entire inventories even!
- `flashstep`: Teleports adventurer to cursor
- `ghostly`: Turns an adventurer into a ghost or back
- `questport`: Sends your adventurer to the location of your quest log cursor
- `view-unit-reports`: opens the reports screen with combat reports for the selected unit

Fixes
-----
- `devel/inject-raws`: now recognizes spaces in reaction names
- `dig`: added support for designation priorities - fixes issues with designations from ``digv`` and related commands having extremely high priority
- `dwarfmonitor`:
    - fixed display of creatures and poetic/music/dance forms on ``prefs`` screen
    - added "view unit" option
    - now exposes the selected unit to other tools
- `names`: fixed many errors
- `quicksave`: fixed an issue where the "Saving..." indicator often wouldn't appear

Misc Improvements
-----------------
- `binpatch`: now reports errors for empty patch files
- `force`: now provides useful help
- `full-heal`:
    - can now select corpses to resurrect
    - now resets body part temperatures upon resurrection to prevent creatures from freezing/melting again
    - now resets units' vanish countdown to reverse effects of `exterminate`
- `gui/gm-unit`:
    - added a profession editor
    - misc. layout improvements
- `launch`: can now ride creatures
- `names`: can now edit names of units
- `remotefortressreader`:
    - support for moving adventurers
    - support for vehicles, gem shapes, item volume, art images, item improvements

Removed
-------
- `tweak`: ``kitchen-keys``: :bug:`614` fixed in DF 0.44.04

Internals
---------
- ``Gui::getAnyUnit()`` supports many more screens/menus

Structures
----------
- New globals: ``soul_next_id``


DFHack 0.44.05-alpha1
=====================

Misc Improvements
-----------------
- `gui/liquids`: added more keybindings: 0-7 to change liquid level, P/B to cycle backwards

Structures
----------
- ``incident``: re-aligned again to match disassembly


DFHack 0.44.04-alpha1
=====================

Fixes
-----
- `devel/inject-raws`: now recognizes spaces in reaction names
- `exportlegends`: fixed an error that could occur when exporting empty lists

Structures
----------
- ``artifact_record``: fixed layout (changed in 0.44.04)
- ``incident``: fixed layout (changed in 0.44.01) - note that many fields have moved


DFHack 0.44.03-beta1
====================

Fixes
-----
- `autolabor`, `autohauler`, `labormanager`: added support for "put item on display" jobs and building/destroying display furniture
- `gui/gm-editor`: fixed an error when editing primitives in Lua tables

Misc Improvements
-----------------
- `devel/dump-offsets`: now ignores ``index`` globals
- `gui/pathable`: added tile types to sidebar
- `modtools/skill-change`:
    - now updates skill levels appropriately
    - only prints output if ``-loud`` is passed

Structures
----------
- Added ``job_type.PutItemOnDisplay``
- Added ``twbt_render_map`` code offset on x64
- Fixed an issue preventing ``enabler`` from being allocated by DFHack
- Found ``renderer`` vtable on osx64
- New globals:
    - ``version``
    - ``min_load_version``
    - ``movie_version``
    - ``basic_seed``
    - ``title``
    - ``title_spaced``
    - ``ui_building_resize_radius``
- ``adventure_movement_optionst``, ``adventure_movement_hold_tilest``, ``adventure_movement_climbst``: named coordinate fields
- ``mission``: added type
- ``unit``: added 3 new vmethods: ``getCreatureTile``, ``getCorpseTile``, ``getGlowTile``
- ``viewscreen_assign_display_itemst``: fixed layout on x64 and identified many fields
- ``viewscreen_reportlistst``: fixed layout, added ``mission_id`` vector
- ``world.status``: named ``missions`` vector


DFHack 0.44.03-alpha1
=====================

Lua
---
- Improved ``json`` I/O error messages
- Stopped a crash when trying to create instances of classes whose vtable addresses are not available


DFHack 0.44.02-beta1
====================

New Scripts
-----------
- `devel/check-other-ids`: Checks the validity of "other" vectors in the ``world`` global
- `gui/cp437-table`: An in-game CP437 table

Fixes
-----
- Fixed issues with the console output color affecting the prompt on Windows
- `createitem`: stopped items from teleporting away in some forts
- `gui/gm-unit`: can now edit mining skill
- `gui/quickcmd`: stopped error from adding too many commands
- `modtools/create-unit`: fixed error when domesticating units

Misc Improvements
-----------------
- The console now provides suggestions for built-in commands
- `devel/export-dt-ini`: avoid hardcoding flags
- `exportlegends`:
    - reordered some tags to match DF's order
    - added progress indicators for exporting long lists
- `gui/gm-editor`: added enum names to enum edit dialogs
- `gui/gm-unit`: made skill search case-insensitive
- `gui/rename`: added "clear" and "special characters" options
- `remotefortressreader`:
    - includes item stack sizes
    - some performance improvements

Removed
-------
- `warn-stuck-trees`: :bug:`9252` fixed in DF 0.44.01

Lua
---
- Exposed ``get_vector()`` (from C++) for all types that support ``find()``, e.g. ``df.unit.get_vector() == df.global.world.units.all``

Structures
----------
- Added ``buildings_other_id.DISPLAY_CASE``
- Fixed ``unit`` alignment
- Fixed ``viewscreen_titlest.start_savegames`` alignment
- Identified ``historical_entity.unknown1b.deities`` (deity IDs)
- Located ``start_dwarf_count`` offset for all builds except 64-bit Linux; `startdwarf` should work now


DFHack 0.44.02-alpha1
=====================

New Scripts
-----------
- `devel/dump-offsets`: prints an XML version of the global table included in in DF

Fixes
-----
- Fixed a crash that could occur if a symbol table in symbols.xml had no content

Lua
---
- Added a new ``dfhack.console`` API
- API can now wrap functions with 12 or 13 parameters

Structures
----------
- The former ``announcements`` global is now a field in ``d_init``
- The ``ui_menu_width`` global is now a 2-byte array; the second item is the former ``ui_area_map_width`` global, which is now removed
- ``world`` fields formerly beginning with ``job_`` are now fields of ``world.jobs``, e.g. ``world.job_list`` is now ``world.jobs.list``


