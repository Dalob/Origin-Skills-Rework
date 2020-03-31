-- -- From Norbyte's SkillMath.lua

-- local function GetVitalityBoostByLevel(level)
--     local extra = Ext.ExtraData
--     local expGrowth = extra.VitalityExponentialGrowth
--     local growth = expGrowth ^ level

--     if level >= extra.FirstVitalityLeapLevel then
--         growth = growth * extra.FirstVitalityLeapGrowth / expGrowth
--     end

--     if level >= extra.SecondVitalityLeapLevel then
--         growth = growth * extra.SecondVitalityLeapGrowth / expGrowth
--     end

--     if level >= extra.ThirdVitalityLeapLevel then
--         growth = growth * extra.ThirdVitalityLeapGrowth / expGrowth
--     end

--     if level >= extra.FourthVitalityLeapLevel then
--         growth = growth * extra.FourthVitalityLeapGrowth / expGrowth
--     end

--     local vit = level * extra.VitalityLinearGrowth + extra.VitalityStartingAmount * growth
--     return Ext.Round(vit / 5.0) * 5.0
-- end

-- local function GetLevelScaledDamage(level)
--     local vitalityBoost = GetVitalityBoostByLevel(level)
--     return vitalityBoost / (((level - 1) * Ext.ExtraData.VitalityToDamageRatioGrowth) + Ext.ExtraData.VitalityToDamageRatio)
-- end

-- local function GetAverageLevelDamage(level)
--     local scaled = GetLevelScaledDamage(level)
--     return ((level * Ext.ExtraData.ExpectedDamageBoostFromAttributePerLevel) + 1.0) * scaled
--         * ((level * Ext.ExtraData.ExpectedDamageBoostFromSkillAbilityPerLevel) + 1.0)
-- end

-- -- My stuff

-- local function GetAverageLevelDamagePercentRange(character, percent, range)

--     local damage = GetAverageLevelDamage(CharacterGetLevel(character)) * percent / 100.0
--     local rand = 1.0 + (Ext.Random(0, range) - range/2) * 0.01

--     local finalDamage = damage * rand
--     finalDamage = math.max(Ext.Round(finalDamage), 1)

--     return damage

-- end
-- Ext.NewQuery(GetAverageLevelDamagePercentRange, "OSR_GetAverageLevelDamagePercentRange", "[in](CHARACTERGUID)_Character, [in](REAL)_Percent, [in](REAL)_Range, [out](INTEGER)_Damage");

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

    NRD_CharacterSetStatInt(target, "CurrentArmor", armor)
    NRD_CharacterSetStatInt(target, "CurrentMagicArmor", magicArmor)

end
Ext.NewCall(SetArmorValues, "OSR_SetArmorValues", "(CHARACTERGUID)_Target, (REAL)_Armor, (REAL)_MagicArmor");