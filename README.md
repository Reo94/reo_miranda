# REO Miranda Rights Card v0.4.1

REO Development Miranda Rights reference card for active FiveM law-enforcement roleplay.

## v0.4.1 - Ox Lib Native UI

This build removes the original custom HTML/CSS/JavaScript NUI completely. The card is displayed with `ox_lib` TextUI, so opening the card does **not** call `SetNuiFocus` and does not intentionally lock player movement or camera control.

### Controls
- **F** - Flip front/back
- **ESC** - Close card
- `/miranda` - Development/fallback toggle when enabled in `config.lua`

### Dependencies
- ox_lib
- ox_inventory

### Install
1. Place `reo_miranda` in your resources folder.
2. Add the item definition from `install/ox_inventory_item.lua` to your ox_inventory items.
3. Ensure resource order includes `ox_lib`, `ox_inventory`, then `reo_miranda`.
4. Restart the server after adding the inventory item.

### Development Note
The temporary `prop_notepad_01` physical prop remains enabled for attachment testing. It can be disabled or adjusted in `config.lua`.

## REO Development
Keep attribution and license terms included with the resource.


## v0.4.1 Prop / ESC Fix
- Consumes ESC while the card is open so the GTA pause menu does not also open.
- Creates the temporary prop as a local mission entity and verifies it is attached to the player hand.
- Cleans up the prop if attachment fails.
