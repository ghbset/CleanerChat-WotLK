# CleanerChat

A World of Warcraft (3.3.5a / WotLK) addon that cleans up the chat, making it prettier and easier on the eye.

## Description

CleanerChat filters and reformats chat messages to reduce clutter and improve readability. It handles:

- **Loot messages** - Consolidates multiple loot pickups into cleaner summaries
- **Loot rolls** - Cleans up Need, Greed, Disenchant, and Pass roll messages
- **Money** - Formats gold/silver/copper with icons
- **Experience & Reputation** - Cleaner XP and rep gain messages
- **Achievements** - Streamlined achievement notifications
- **Spells & Abilities** - Consolidated spell learning messages
- **Auctions** - Cleaner auction house notifications
- **Quest updates** - Simplified quest progress messages
- **Quest rewards** - Formats reward item messages
- **Crafting** - Reformats "creates" broadcasts
- **Channel names** - Shortened channel prefixes
- **Player names** - Class-colored names in chat
- **Item quality** - Color-coded item names by rarity

## Installation

1. Download the addon.
2. Extract to `Interface\AddOns\CleanerChat`.
3. Restart WoW or type `/reload`.

## Commands

- `/cleanerchat` or `/cc` - Open the options panel.

## Compatibility

Built for the 3.3.5a (WotLK, interface `30300`) client and tested on the Ascension WoW private server. Includes:

- A `C_Timer` polyfill for timer functionality
- `C_AddOns` compatibility shims
- Safe pattern matching with nil checks
- Loot roll formatting (Need/Greed/Disenchant/Pass)
- Quest reward and crafting message formatting

## Credits

CleanerChat was **inspired by** the ChatCleaner addon by Lars Norberg (Goldpaw). CleanerChat is an independent project maintained by migwynkriid.

## License

Custom License - see [LICENSE.txt](LICENSE.txt).
