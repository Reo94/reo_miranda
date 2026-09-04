--[[
    ============================================================
    REO DEVELOPMENT - MIRANDA RIGHTS CARD
    OX LIB NATIVE UI BUILD
    ============================================================
]]

-- ============================================================
-- RESOURCE INFORMATION
-- ============================================================

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'REO Development'
description 'Ox Lib native Miranda Rights reference card for active law enforcement roleplay.'
version '0.4.1'

-- ============================================================
-- DEPENDENCIES
-- ============================================================

dependency 'ox_lib'
dependency 'ox_inventory'

-- ============================================================
-- SHARED FILES
-- ============================================================

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

-- ============================================================
-- CLIENT / SERVER FILES
-- ============================================================

client_script 'client/main.lua'
server_script 'server/main.lua'

-- ============================================================
-- NO CUSTOM WEB/NUI
-- ============================================================
-- This build intentionally uses ox_lib TextUI. There is no
-- ui_page, HTML, CSS, JavaScript, or SetNuiFocus requirement.
