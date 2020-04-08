local function IsSoulWolf(character)

    local name = NRD_CharacterGetStatString(character, "Name")

    if (name == "Animals_SoulWolfSmallOSR") or (name == "Animals_SoulWolfGiantOSR") then
        return true
    end

    return false

end
Ext.NewQuery(IsSoulWolf, "OSR_IsSoulWolf", "[in](CHARACTERGUID)_Character");

local function IsAnArmorDepleted(character)

    local armor = NRD_CharacterGetStatInt(character, "CurrentArmor")
    local magicArmor = NRD_CharacterGetStatInt(character, "CurrentMagicArmor")

    if (armor == 0) or (magicArmor == 0) then
        return true
    end

    return false

end
Ext.NewQuery(IsAnArmorDepleted, "OSR_IsAnArmorDepleted", "[in](CHARACTERGUID)_Character");

local function GetArmorValues(character)

    local armor = NRD_CharacterGetStatInt(character, "CurrentArmor")
    local magicArmor = NRD_CharacterGetStatInt(character, "CurrentMagicArmor")

    return armor, magicArmor

end
Ext.NewQuery(GetArmorValues, "OSR_GetArmorValues", "[in](CHARACTERGUID)_Character, [out](REAL)_ArmorPercent, [out](REAL)_MagicArmorPercent");

local function SetArmorValues(target, armor, magicArmor)

    local maxArmor = NRD_CharacterGetStatInt(target, "MaxArmor")
    local maxMagicArmor = NRD_CharacterGetStatInt(target, "MaxMagicArmor")

    if (maxArmor) then
        CharacterSetArmorPercentage(target, armor / maxArmor * 100)
    end

    if (maxMagicArmor) then
        CharacterSetMagicArmorPercentage(target, magicArmor / maxMagicArmor * 100)
    end

    -- Doesn't show the armour value being restored with text
    -- NRD_CharacterSetStatInt(target, "CurrentArmor", armor)
    -- NRD_CharacterSetStatInt(target, "CurrentMagicArmor", magicArmor)

end
Ext.NewCall(SetArmorValues, "OSR_SetArmorValues", "(CHARACTERGUID)_Target, (REAL)_Armor, (REAL)_MagicArmor");