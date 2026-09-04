--[[
    ============================================================
    REO DEVELOPMENT - MIRANDA RIGHTS CARD
    SERVER MAIN - OX LIB BUILD
    ============================================================
]]

-- ============================================================
-- SERVER INITIALIZATION
-- ============================================================

CreateThread(function()
    if Config.Debug then
        print(('[REO Miranda] %s server component loaded.'):format(Config.ResourceName))
    end
end)

-- ============================================================
-- RESERVED FOR FUTURE SERVER FEATURES
-- ============================================================
-- Future uses may include department permissions, audit hooks,
-- MDT integration, or server-authoritative configuration.
