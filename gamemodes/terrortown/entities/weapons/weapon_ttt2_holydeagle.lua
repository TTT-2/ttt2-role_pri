SWEP.Base = 'weapon_tttbase'

SWEP.Spawnable = true
SWEP.AutoSpawnable = false
SWEP.AdminSpawnable = true

SWEP.HoldType = 'pistol'

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

if SERVER then
	AddCSLuaFile()

	resource.AddFile('materials/vgui/ttt/icon_sidekickdeagle.vmt')

	util.AddNetworkString('tttSidekickMSG')
else
	hook.Add('Initialize', 'TTTInitSikiDeagleLang', function()
		LANG.AddToLanguage('English', 'ttt2_weapon_holydeagle_desc', 'Shoot a player to make him holy, but be careful to shoot only innocent people.')
		LANG.AddToLanguage('Deutsch', 'ttt2_weapon_holydeagle_desc', 'Schieße auf einen Spieler, um ihn heilig zu machen. Aber pass auf nur auf Unschuldige zu schießen.')
	end)

	SWEP.PrintName = 'Holy Deagle'
	SWEP.Author = 'Mineotopia'

	SWEP.Slot = 7

	SWEP.ViewModelFOV = 54
	SWEP.ViewModelFlip = false

	SWEP.Category = 'Deagle'
	SWEP.Icon = 'vgui/ttt/icon_sidekickdeagle.vtf'
	SWEP.EquipMenuData = {
		type = 'Weapon',
		desc = 'ttt2_weapon_sidekickdeagle_desc'
	}
end

SWEP.AllowDrop              = false
SWEP.notBuyable             = true

-- dmg
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 6
SWEP.Primary.Automatic = false
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.00001
SWEP.Primary.Ammo = ''
SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1

-- some other stuff
SWEP.InLoadoutFor = nil
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.UseHands = true
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {}
SWEP.LimitedStock = true
SWEP.globalLimited = true
SWEP.NoRandom = true

-- view / world
SWEP.ViewModel = 'models/weapons/cstrike/c_pist_deagle.mdl'
SWEP.WorldModel = 'models/weapons/w_pist_deagle.mdl'
SWEP.Weight = 5
SWEP.Primary.Sound = Sound('Weapon_Deagle.Single')

SWEP.IronSightsPos = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.notBuyable = true

function SWEP:OnDrop()
	self:Remove()
end

local function RefillHolyDeagle(swep)
	if not swep or not IsValid(swep) then return end
	swep:SetClip1(1)
end

function SWEP:PrimaryAttack()
	local BaseClass = baseclass.Get(self.Base)
	BaseClass.PrimaryAttack(self)

	timer.Create('ttt2_priest_refill_holy_deagle', GetConVar('ttt_pri_refill_time'):GetInt(), 1, function() RefillHolyDeagle(self) end)
end

if SERVER then
	hook.Add('ScalePlayerDamage', 'HolyHitReg', function(ply, hitgroup, dmginfo)
		local attacker = dmginfo:GetAttacker()
		if GetRoundState() ~= ROUND_ACTIVE or not attacker or not IsValid(attacker)
			or not attacker:IsPlayer() or not IsValid(attacker:GetActiveWeapon()) then return end

		if not ply or not ply:IsPlayer() then return end

		local weap = attacker:GetActiveWeapon()

		if weap:GetClass() ~= 'weapon_ttt2_holydeagle' then return end

		PRIEST_DATA:ShootBrotherhood(ply, attacker)
		dmginfo:SetDamage(0)
		return true
	end)
end


-- auto add sidekick weapon into jackal shop
-- hook.Add('LoadedFallbackShops', 'SidekickDeagleAddToShop', function()
-- 	if JACKAL and SIDEKICK and JACKAL.fallbackTable then
-- 		AddWeaponIntoFallbackTable('weapon_ttt2_sidekickdeagle', JACKAL)
-- 	end
-- end)

-- if CLIENT then
-- 	hook.Add('TTT2FinishedLoading', 'InitSikiMsgText', function()
-- 		LANG.AddToLanguage('English', 'ttt2_siki_shot', 'Successfully shot {name} as Sidekick!')
-- 		LANG.AddToLanguage('Deutsch', 'ttt2_siki_shot', 'Erfolgreich {name} als Sidekick geschossen!')
-- 	end)

-- 	net.Receive('tttSidekickMSG', function(len)
-- 		local target = net.ReadEntity()

-- 		if not target or not IsValid(target) then return end

-- 		local text = LANG.GetParamTranslation('ttt2_siki_shot', {name = target:GetName()})
-- 		MSTACK:AddMessage(text)
-- 	end)
-- end
