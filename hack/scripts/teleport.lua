-- teleports a unit to a location
-- author Putnam
-- edited by expwnent
--@module = true
--[====[

teleport
========
Teleports a unit to given coordinates.

.. note::

    `gui/teleport` is an in-game UI for this script.

Examples:

* prints ID of unit beneath cursor::

    teleport -showunitid

* prints coordinates beneath cursor::

    teleport -showpos

* teleports unit ``1234`` to ``56,115,26``

    teleport -unit 1234 -x 56 -y 115 -z 26

]====]

function teleport(unit,pos)
 local oldOccupancy = dfhack.maps.getTileBlock(unit.pos).occupancy[unit.pos.x%16][unit.pos.y%16]
 local newOccupancy = dfhack.maps.getTileBlock(pos).occupancy[tonumber(pos.x)%16][tonumber(pos.y)%16]
 unit.pos.x = tonumber(pos.x)
 unit.pos.y = tonumber(pos.y)
 unit.pos.z = tonumber(pos.z)
 if unit.flags1.on_ground then
  oldOccupancy.unit_grounded = false
  newOccupancy.unit_grounded = true
 else
  oldOccupancy.unit = false
  if newOccupancy.unit then -- only 1 non-prone unit is normally allowed to occupy a tile
   unit.flags1.on_ground = true
   newOccupancy.unit_grounded = true
  else
   newOccupancy.unit = true
  end
 end
end

local utils = require('utils')

local validArgs = utils.invert({
 'unit',
 'x',
 'y',
 'z',
 'showunitid',
 'showpos'
})

if moduleMode then
 return
end

local args = utils.processArgs({...}, validArgs)

if args.showunitid or args.showpos then
 if args.showunitid then
  print(dfhack.gui.getSelectedUnit(true).id)
 else
  printall(df.global.cursor)
 end
else
 local unit = tonumber(args.unit) and df.unit.find(tonumber(args.unit)) or dfhack.gui.getSelectedUnit(true)
 local pos = not(not args.x or not args.y or not args.z) and {x=args.x,y=args.y,z=args.z} or {x=df.global.cursor.x,y=df.global.cursor.y,z=df.global.cursor.z}
 if not unit then qerror('A unit needs to be selected or specified. Use teleport -showunitid to get a unit\'s ID.') end
 if not pos.x or pos.x==-30000 then qerror('A position needs to be highlighted or specified. Use teleport -showpos to get a position\'s exact xyz values.') end
 teleport(unit,pos)
end
