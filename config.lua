--[[
    ============================================================
    REO DEVELOPMENT - MIRANDA RIGHTS CARD
    CONFIGURATION - OX LIB NATIVE UI BUILD
    ============================================================
]]

Config = {}

-- ============================================================
-- GENERAL SETTINGS
-- ============================================================

Config.Debug = true
Config.ResourceName = 'REO Miranda'

-- ============================================================
-- OX INVENTORY SETTINGS
-- ============================================================

Config.CardItem = 'miranda_card'
Config.UseOxInventory = true

-- ============================================================
-- DEVELOPMENT COMMAND
-- ============================================================

Config.AllowCommand = true
Config.CommandName = 'miranda'

-- ============================================================
-- CARD SETTINGS
-- ============================================================

Config.AllowCardFlip = true

-- ============================================================
-- OX LIB NOTIFICATIONS
-- ============================================================

Config.Notifications = true
Config.NotifyPosition = 'top-right'

-- ============================================================
-- OX LIB TEXT UI
-- This replaces the original custom web/NUI interface.
-- TextUI does not take NUI focus, allowing the officer to move,
-- look around, and continue active RP while reading the card.
-- ============================================================

Config.TextUIPosition = 'right-center'
Config.TextUIIcon = 'address-card'
Config.TextUIIconAnimation = nil

Config.TextUIStyle = {
    borderRadius = 6,
    backgroundColor = 'rgba(20, 24, 30, 0.72)',
    color = 'rgba(245, 245, 245, 0.96)',
    maxWidth = '390px',
    lineHeight = '1.35'
}

-- ============================================================
-- PHYSICAL PROP / ANIMATION SETTINGS
-- ============================================================

Config.UseAnimation = false
Config.UseTemporaryProp = true

Config.CardProp = {
    model = `prop_notepad_01`,
    bone = 57005,
    position = vec3(0.10, 0.02, -0.02),
    rotation = vec3(10.0, 0.0, 90.0)
}
