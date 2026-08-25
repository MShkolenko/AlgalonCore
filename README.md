# AlgalonCore

Серверное ядро World of Warcraft для патча **11.2.7.65299**, которое развивается дальше из копии
[TrinityCore](https://github.com/TrinityCore/TrinityCore).

Это не TrinityCore и не говорит от его имени: найденные здесь ошибки туда не сообщаются, а их
ошибки — не наши.

## Откуда начинается

| | |
|---|---|
| Версия, взятая у TrinityCore | `8d31f000f7` — *TDB 1127.26011 - 14.01.2026* |
| База мира | TDB **1127.26011** (официальная, выпущена 14.01.2026) |
| Клиент | **11.2.7.65299** (розничный, 15.01.2026) |

Это последняя версия ядра, совместимая с базой мира TDB 1127.26011 — поэтому проект закреплён
именно на ней, а не на подвижной ветке `master` у TrinityCore. Тег `trinitycore-8d31f00`
отмечает точку, с которой копия была взята.

История TrinityCore сюда не перенесена: она уходит в 2008 год, а GitHub отказывается принимать
коммиты 2008-2010 годов — в них испорчены строки автора, и проверка объектов их отклоняет.
Полная история осталась у TrinityCore и в клоне на сервере, где `git blame` по-прежнему доходит
до самого начала. При переносе убраны пять файлов их CI (275 строк) — они собирали TrinityCore
на серверах GitHub и расставляли ярлыки по его собственному справочнику. Все остальные файлы
совпадают с оригиналом байт в байт.

## Зачем это

Полигон для проверки. Боты играют как настоящие игроки — им позволено только то, что мог бы
отправить настоящий клиент, — и, наткнувшись на поломку, **замирают на месте**, вместо того чтобы
её обойти. Бот, стоящий у сломанного квестодателя, и есть результат: это отчёт об ошибке с
координатами.

## Лицензия

TrinityCore распространяется под **GPL-2.0**, и эта производная работа сохраняет ту же лицензию —
см. [COPYING](COPYING). Авторы кода, с которого всё начинается, перечислены в [AUTHORS](AUTHORS);
этот файл и указания об авторских правах внутри исходников остаются нетронутыми.

---

<details>
<summary><strong>English</strong></summary>

<br>

A World of Warcraft server core for patch **11.2.7.65299**, developed forward from a copy of
[TrinityCore](https://github.com/TrinityCore/TrinityCore).

This is not TrinityCore and does not speak for it: bugs found here are not reported there, and
theirs are not ours.

### Where it starts

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

### What it is for

A QA testbed. Bots play as real players — only what a real client could send — and **freeze in
place when something breaks** instead of skipping past it. A bot standing still at a broken
questgiver is the product: a bug report with coordinates.

### Licence

TrinityCore is licensed **GPL-2.0**, and this derivative keeps that licence — see [COPYING](COPYING).
The authors of the code this starts from are listed in [AUTHORS](AUTHORS); that file, and the
copyright notices inside the source files, stay exactly as they are.

</details>
