-- ============================================================
-- REO DEVELOPMENT - MIRANDA RIGHTS CARD
-- OX_INVENTORY ITEM DEFINITION
-- ============================================================
-- Add this entry inside ox_inventory/data/items.lua

['miranda_card'] = {
    label = 'Miranda Rights Card',
    weight = 10,
    stack = false,
    close = true,
    consume = 0,
    description = 'A laminated law enforcement reference card containing the Miranda warning and rights waiver.',
    client = {
        export = 'reo_miranda.useMirandaCard'
    }
},
