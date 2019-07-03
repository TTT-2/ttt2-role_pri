SWEP.Base = 'weapon_tttbase'

SWEP.Spawnable = true
SWEP.AutoSpawnable = false
SWEP.AdminSpawnable = true

SWEP.HoldType = 'pistol'

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

if SERVER then
	AddCSLuaFile()

	resource.AddFile('materials/vgui/ttt/icon_holydeagle.vmt')
else
	hook.Add('Initialize', 'TTTInitHolyDeagleLang', function()
		LANG.AddToLanguage('English', 'ttt2_weapon_holydeagle_desc', 'Shoot a player to make him holy, but be careful to shoot only innocent people.')
		LANG.AddToLanguage('Deutsch', 'ttt2_weapon_holydeagle_desc', 'Schieße auf einen Spieler, um ihn heilig zu machen. Aber pass auf nur auf Unschuldige zu schießen.')
	end)

	SWEP.PrintName = 'Holy Deagle'
	SWEP.Author = 'Mineotopia'

	SWEP.Slot = 7

	SWEP.ViewModelFOV = 54
	SWEP.ViewModelFlip = false

	SWEP.Category = 'Deagle'
	SWEP.Icon = 'vgui/ttt/icon_holydeagle.vtf'
	SWEP.EquipMenuData = {
		type = 'item_weapon',
		desc = 'ttt2_weapon_holydeagle_desc'
	}
end

SWEP.AllowDrop = false
SWEP.notBuyable = true

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

function SWEP:OnDrop()
	self:Remove()
end

local function RefillHolyDeagle(swep)
	if not swep or not IsValid(swep) then return end
	swep:SetClip1(1)
end

function SWEP:PrimaryAttack()
	if SERVER and self:Clip1() > 0 then
		timer.Create('ttt2_priest_refill_holy_deagle_' .. tostring(self:EntIndex()), GetConVar('ttt_pri_refill_time_missed'):GetInt(), 1, function() RefillHolyDeagle(self) end)
		PRIEST_DATA:SetRechargeIcon(self.Owner, GetConVar('ttt_pri_refill_time_missed'):GetInt())
	end
	
	local BaseClass = baseclass.Get(self.Base)
	BaseClass.PrimaryAttack(self)
end

if SERVER then
	hook.Add('ScalePlayerDamage', 'HolyHitReg', function(ply, hitgroup, dmginfo)
		local attacker = dmginfo:GetAttacker()
		if GetRoundState() ~= ROUND_ACTIVE or not attacker or not IsValid(attacker)
			or not attacker:IsPlayer() or not IsValid(attacker:GetActiveWeapon()) then return end

		if not ply or not ply:IsPlayer() then return end

		local weap = attacker:GetActiveWeapon()

		if weap:GetClass() ~= 'weapon_ttt2_holydeagle' then return end

		-- change refill time
		timer.Remove('ttt2_priest_refill_holy_deagle_' .. tostring(weap:EntIndex()))
		timer.Simple(0.05, function() -- a time can't be added instantly after removing it
			timer.Create('ttt2_priest_refill_holy_deagle_' .. tostring(weap:EntIndex()), GetConVar('ttt_pri_refill_time'):GetInt(), 1, function() RefillHolyDeagle(weap) end)
			PRIEST_DATA:SetRechargeIcon(attacker, GetConVar('ttt_pri_refill_time'):GetInt())
		end)

		-- handle weapon
		PRIEST_DATA:ShootBrotherhood(ply, attacker)
		dmginfo:SetDamage(0)
		return true
	end)
end
