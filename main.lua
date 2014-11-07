
function Dms(_deg, _min, _sec)
   return _deg + _min/60 + _sec/3600
end
 
function Pos(_lat, _lon) 
   return {lat = _lat, lon = _lon}
end
 
function Area(_a,_b)
  local minlat = math.min(_a.lat,_b.lat)
  local maxlat = math.max(_a.lat,_b.lat)
  local minlon = math.min(_a.lon,_b.lon)
  local maxlon = math.max(_a.lon,_b.lon)
  return {lat = minlat+(maxlat-minlat)*math.random(), lon = minlon+(maxlon-minlon)*math.random()}
end
 
function Orientation(_pos, _rotation) 
  return { lat = _pos.lat, lon = _pos.lon, orient = _rotation }
end
 
function ID(_shipid) 
  return {id = _shipid}
end
 
function Random(_ids)
  local function chooseRand(items)
    return items[math.random(1, #items)]
  end
  if #_ids == 0 then error('cannot select an entry from an empty list') end
  return {id=chooseRand(_ids)}
end
 
function RandomWeighted(_table) 
  local sum = 0
  local length = 0
  for k, v in pairs(_table) do
    sum = sum + v
    length = length + 1
  end
  if sum == 0 and length == 0 then error('cannot select an entry from an empty list') end
  local rand = math.random()
  local isum = 0
  for k, v in pairs(_table) do
    if ((isum + v)/sum > rand) then
      return {id=k}
    end
    isum = isum + v
  end
end

function Side(_name) 
   return {type = 'Side', name = _name}
end

function Mission(_name)
   return {type = 'Mission', name = _name}
end

function Group(_name)
  return {type = 'Group', name = _name}
end

function Unit(_name)
  return {type = 'Unit', name = _name}
end

local function GetType(_obj) return _obj.type end
local function GetName(_obj) return _obj.name end


EMCON = {Passive = 0, Active = 1}
function SetEMCON(_obj, _desc)
  if _desc == {} then
    ScenEdit_SetEMCON(GetType(_obj),GetName(_obj),'Inherit')
  end

  local cstr = {}
  if _desc.Radar ~= nil then
    if _desc.Radar == EMCON.Passive then
      table.insert(cstr,"Radar=Passive")
    end
    if _desc.Radar == EMCON.Active then
      table.insert(cstr,"Radar=Active")
    end
  end
  if _desc.Sonar ~= nil then
    if _desc.Sonar == EMCON.Passive then
      table.insert(cstr,"Sonar=Passive")
    end
    if _desc.Sonar == EMCON.Active then
      table.insert(cstr,"Sonar=Active")
    end
  end
  if _desc.OECM ~= nil then
    if _desc.OECM == EMCON.Passive then
      table.insert(cstr,"OECM=Passive")
    end
    if _desc.OECM == EMCON.Active then
      table.insert(cstr,"OECM=Active")
    end
  end
  ScenEdit_SetEMCON(GetType(_obj),GetName(_obj),table.concat(cstr,';'))
end
 
function AddShip(_side, _name, _spawn, _pos)
   ScenEdit_AddShip(_side, _name, _spawn.id, 'DEC', _pos.lat, _pos.lon)
end
 
function AddAircraft(_side, _name, _spawn, _loadout, _pos)
   ScenEdit_AddAircraft(_side, _name, _spawn.id, _loadout, 'DEC', _pos.lat, _pos.lon)
end
 
function AddSubmarine(_side, _name, _spawn, _pos)
   ScenEdit_AddSubmarine(_side, _name, _spawn.id, 'DEC', _pos.lat, _pos.lon)
end
 
function AddFacility(_side, _name, _spawn, _pos)
   if _pos.orient == nil then
     _pos.orient = 0
   end
   ScenEdit_AddFacility(_side, _name, _spawn.id, _pos.orient, 'DEC', _pos.lat, _pos.lon)
end