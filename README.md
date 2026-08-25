**English** | [Русский](README.ru.md)

# AlgalonCore

A World of Warcraft server core for patch **11.2.7.65299**, developed forward from a copy of
[TrinityCore](https://github.com/TrinityCore/TrinityCore).

This is not TrinityCore and does not speak for it: bugs found here are not reported there, and
theirs are not ours.

## Where it starts

| | |
|---|---|
| Upstream revision | `8d31f000f7` — *TDB 1127.26011 - 2026/01/14* |
| World database | TDB **1127.26011** (official, released 2026-01-14) |
| Client | **11.2.7.65299** (retail, 2026-01-15) |

That revision is the last one compatible with TDB 1127.26011, which is why the project is anchored
there rather than at upstream's moving `master`. The tag `trinitycore-8d31f00` marks the exact
import commit.

Upstream history is not carried here — it reaches back to 2008 and GitHub refuses commits from
2008-2010 whose author lines fail its object check. The full history lives upstream, and in the
server-side clone where `git blame` still resolves through it. Five upstream CI workflow files
were dropped at import (275 lines); every other file is byte for byte upstream.

## What it is for

A QA testbed. Bots play as real players — only what a real client could send — and **freeze in
place when something breaks** instead of skipping past it. A bot standing still at a broken
questgiver is the product: a bug report with coordinates.

## Licence

TrinityCore is licensed **GPL-2.0**, and this derivative keeps that licence — see [COPYING](COPYING).
The authors of the code this starts from are listed in [AUTHORS](AUTHORS); that file, and the
copyright notices inside the source files, stay exactly as they are.
