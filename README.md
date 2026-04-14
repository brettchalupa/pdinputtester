# Sunny ☀️ - Playdate Lua Template

Hit the ground running with this game dev template for Playdate + Lua made by
Brett Chalupa (a.k.a. Brett Makes Games).

Currently targeted Playdate SDK version: 3.0.

## Features / Bugs

- Essential scenes: main menu, gameplay, credits
- Save data with playtime tracking
- Sound effect with setting toggle in Playdate menu
- Lua language formatting and server protocol support
- `just` commands
- itch.io release script: `just release`
- 2 space indentation, soft tabs
- Nice Zed editor config
- Optimized for macOS (but works on other operating system)

## Template License

All of the code and assets in this template is released into the public domain,
unless otherwise noted. Pick your own license for your game once you make it.

Asheville font by Panic, licensed for use under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) license](https://creativecommons.org/licenses/by/4.0/).

## Use the Template

Delete everything above, update `YOURGAME` accordingly throughout the source,
and make a great game.

---

# YOURGAME

## Prerequisites

- [Playdate SDK](https://play.date/dev/)
- [git](https://git-scm.com/)
- [just](https://just.systems/)
- Ruby
- [itch.io butler](https://itch.io/docs/butler/) - if you want to release on itch.io

On macOS you can install all prerequisites via [Homebrew](https://brew.sh/) by
running:

```
brew bundle
```

## Setup

After cloning, initialize the vendored submodules by running:

```
just setup
```

## Reference

- [Playdate SDK docs](https://sdk.play.date)
- [Designing for Playdate](https://help.play.date/developer/designing-for-playdate/) -
  best practices guide
