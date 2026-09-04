--[[
    ============================================================
    REO DEVELOPMENT - MIRANDA RIGHTS CARD
    CLIENT CONTROLLER - OX LIB NATIVE UI BUILD
    ============================================================
]]

-- ============================================================
-- CLIENT STATE
-- ============================================================

local cardOpen = false
local showingFront = true
local cardProp = nil

-- ============================================================
-- DEBUG HELPER
-- ============================================================

local function debugPrint(message)
    if Config.Debug then
        print(('[REO Miranda] %s'):format(message))
    end
end

-- ============================================================
-- OX LIB NOTIFICATION HELPER
-- ============================================================

local function notify(description, notifyType)
    if not Config.Notifications then return end

    lib.notify({
        title = Config.ResourceName,
        description = description,
        type = notifyType or 'inform',
        position = Config.NotifyPosition
    })
end

-- ============================================================
-- REO DEVELOPMENT - MIRANDA CARD TEXT
-- ============================================================

local function getFrontText()
    return table.concat({
        '**MIRANDA WARNING**',
        '',
        '1. You have the right to remain silent.',
        '',
        '2. Anything you say can and will be used against you in a court of law.',
        '',
        '3. You have the right to talk to a lawyer and have them present with you while you are being questioned.',
        '',
        '4. If you cannot afford to hire a lawyer, one will be appointed to represent you before any questioning if you wish.',
        '',
        '5. You can decide at any time to exercise these rights and not answer any questions or make any statements.',
        '',
        '**Do you understand each of these rights as I have explained them to you?**',
        '',
        '[F] Flip Card   •   [ESC] Close'
    }, '\n')
end

local function getBackText()
    return table.concat({
        '**RIGHTS WAIVER**',
        '',
        '**Having these rights in mind, do you wish to speak with me?**',
        '',
        '• If the individual requests an attorney, questioning should cease.',
        '',
        '• If the individual indicates they do not wish to answer questions, questioning should cease.',
        '',
        '• Document the advisement and the individual\'s response according to department policy.',
        '',
        '**Document the subject\'s response.**',
        '',
        '[F] Flip Card   •   [ESC] Close'
    }, '\n')
end

-- ============================================================
-- OX LIB CARD DISPLAY
-- ============================================================

local function displayCard()
    local text = showingFront and getFrontText() or getBackText()

    lib.showTextUI(text, {
        position = Config.TextUIPosition,
        icon = Config.TextUIIcon,
        iconAnimation = Config.TextUIIconAnimation,
        style = Config.TextUIStyle
    })
end

local function hideCardDisplay()
    lib.hideTextUI()
end

-- ============================================================
-- REO DEVELOPMENT - TEMPORARY CARD PROP
-- ============================================================

local function deleteCardProp()
    if cardProp and DoesEntityExist(cardProp) then
        DetachEntity(cardProp, true, true)
        DeleteEntity(cardProp)
    end

    cardProp = nil
end

local function createCardProp()
    if not Config.UseTemporaryProp or not Config.CardProp then
        return true
    end

    deleteCardProp()

    local model = Config.CardProp.model

    if not IsModelInCdimage(model) or not IsModelValid(model) then
        debugPrint('Configured temporary card prop model is invalid.')
        notify('Temporary card prop could not be loaded.', 'error')
        return false
    end

    lib.requestModel(model, 5000)

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    cardProp = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)

    if not cardProp or cardProp == 0 or not DoesEntityExist(cardProp) then
        cardProp = nil
        SetModelAsNoLongerNeeded(model)
        debugPrint('Failed to create temporary card prop.')
        return false
    end

    SetEntityAsMissionEntity(cardProp, true, true)
    SetEntityCollision(cardProp, false, false)

    local boneIndex = GetPedBoneIndex(ped, Config.CardProp.bone)
    local pos = Config.CardProp.position
    local rot = Config.CardProp.rotation

    AttachEntityToEntity(
        cardProp, ped, boneIndex,
        pos.x, pos.y, pos.z,
        rot.x, rot.y, rot.z,
        true, true, false, true, 1, true
    )

    if not IsEntityAttachedToEntity(cardProp, ped) then
        debugPrint('WARNING: Temporary Miranda card prop failed to attach to player.')
        deleteCardProp()
        SetModelAsNoLongerNeeded(model)
        notify('Miranda card prop failed to attach.', 'error')
        return false
    end

    SetModelAsNoLongerNeeded(model)

    debugPrint('Temporary Miranda card prop attached to player hand.')
    return true
end

-- ============================================================
-- OPEN / CLOSE / FLIP MIRANDA CARD
-- ============================================================

local function openMirandaCard()
    if cardOpen then return false end

    cardOpen = true
    showingFront = true

    createCardProp()
    displayCard()

    debugPrint('Miranda card opened with ox_lib TextUI. Player movement remains enabled.')
    return true
end

local function closeMirandaCard()
    if not cardOpen then return false end

    cardOpen = false
    showingFront = true

    hideCardDisplay()
    deleteCardProp()

    debugPrint('Miranda card closed.')
    return true
end

local function flipMirandaCard()
    if not cardOpen or not Config.AllowCardFlip then return false end

    showingFront = not showingFront
    displayCard()

    debugPrint(showingFront and 'Miranda card flipped to front.' or 'Miranda card flipped to back.')
    return true
end

local function toggleMirandaCard()
    if cardOpen then
        closeMirandaCard()
    else
        openMirandaCard()
    end
end

-- ============================================================
-- OX INVENTORY ITEM EXPORT
-- ============================================================

exports('useMirandaCard', function(data, slot)
    if cardOpen then
        closeMirandaCard()
        return
    end

    if not Config.UseOxInventory then
        openMirandaCard()
        return
    end

    exports.ox_inventory:useItem(data, function(usedItem)
        if not usedItem then return end

        debugPrint(('Miranda card used from inventory slot %s.'):format(slot or 'unknown'))
        openMirandaCard()
    end)
end)

-- ============================================================
-- DEVELOPMENT / FALLBACK COMMAND
-- ============================================================

if Config.AllowCommand then
    RegisterCommand(Config.CommandName, function()
        toggleMirandaCard()
    end, false)
end

-- ============================================================
-- CARD CONTROLS - NO NUI FOCUS
-- ============================================================

CreateThread(function()
    while true do
        if cardOpen then
            Wait(0)

            -- F / INPUT_ENTER - prevent entering vehicles while reading the card.
            DisableControlAction(0, 23, true)

            if IsDisabledControlJustReleased(0, 23) then
                flipMirandaCard()
            end

            -- ESC / GTA frontend pause controls.
            -- Disable these before reading them so REO Miranda consumes
            -- ESC instead of allowing the base-game pause menu to open.
            DisableControlAction(0, 200, true)
            DisableControlAction(0, 199, true)
            DisableControlAction(0, 322, true)

            if IsDisabledControlJustReleased(0, 200)
                or IsDisabledControlJustReleased(0, 199)
                or IsDisabledControlJustReleased(0, 322) then
                closeMirandaCard()
            end
        else
            Wait(250)
        end
    end
end)

-- ============================================================
-- PUBLIC CLIENT EVENTS / EXPORTS
-- ============================================================

RegisterNetEvent('reo_miranda:client:open', openMirandaCard)
RegisterNetEvent('reo_miranda:client:close', closeMirandaCard)

exports('openMirandaCard', openMirandaCard)
exports('closeMirandaCard', closeMirandaCard)
exports('flipMirandaCard', flipMirandaCard)
exports('isMirandaCardOpen', function()
    return cardOpen
end)

-- ============================================================
-- RESOURCE CLEANUP
-- ============================================================

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    cardOpen = false
    showingFront = true
    hideCardDisplay()
    deleteCardProp()
end)
