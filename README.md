# AlgalonCore

![patch](https://img.shields.io/badge/patch-11.2.7.65299-1f6feb)
![TDB](https://img.shields.io/badge/TDB-1127.26011-1f6feb)
![base](https://img.shields.io/badge/base-TrinityCore%208d31f00-6e7681)
![licence](https://img.shields.io/badge/licence-GPL--2.0-238636)

Серверное ядро World of Warcraft, закреплённое на патче **11.2.7.65299**. Начато с копии
[TrinityCore](https://github.com/TrinityCore/TrinityCore) и развивается дальше как отдельный
проект.

> **Это не TrinityCore и не говорит от его имени.** Найденные здесь ошибки туда не сообщаются,
> а их ошибки — не наши. Если вы ищете живой, поддерживаемый сообществом сервер, идите к ним.

## Зачем это существует

Полигон для проверки мира. Боты играют как настоящие игроки — им позволено только то, что мог бы
отправить настоящий клиент, — и, наткнувшись на поломку, **замирают на месте**, вместо того чтобы
её обойти. Бот, застывший у сломанного квестодателя, и есть результат работы: это отчёт об ошибке
с координатами. Всё, что умеет пропустить, объехать или телепортироваться мимо неполадки, здесь
считается уничтожением улик.

Отсюда и выбор версии: на 11.2.7 мир измерим и конечен, поэтому «должно работать» — проверяемое
утверждение, а не пожелание.

## На чём стоит

| | |
|---|---|
| Версия, взятая у TrinityCore | [`8d31f000f7`](https://github.com/TrinityCore/TrinityCore/commit/8d31f000f77ff9c2e26d4a31e559943acf4eff03) — *TDB 1127.26011 - 14.01.2026* |
| База мира | TDB **1127.26011** (официальная, выпущена 14.01.2026) |
| Клиент | **11.2.7.65299** |

Это последняя версия ядра, совместимая с базой мира TDB 1127.26011, — поэтому проект закреплён
именно на ней, а не на подвижной ветке `master` у TrinityCore. Тег `trinitycore-8d31f00` отмечает
точку, с которой копия была взята: всё, что ниже него, — чужая работа, всё, что выше, — наша.

## Чем отличается от оригинала

**Ровно два намеренных расхождения в коде.** Оба помечены `[algalon-local]` в истории и
`// algalon-local` в самом коде, оба найдены глубокой ревизией уже принятых правок, и **оба
пережили бы компиляцию и запуск незамеченными** — это не опечатки, а поведение:

| файл | что и почему |
|---|---|
| `UpdateFieldImpl.h` | Возвращён обход **бага клиента 11.2.x**: клиент заменяет недосланные значения нулями, поэтому слать нужно всё. Апстрим убрал обход, только уйдя на 12.0 — их клиент двинулся дальше, наш нет. Без этого частичное обновление обнуляет раскладку талантов игрока |
| `GuildPackets.h` | Пределы длины гильдейских строк расширены вчетверо. Проверка считает **байты**, а хранилище — **символы**: на кириллице символ занимает 2 байта, и название ранга молча обрезалось на седьмой букве. Откат был недопустим — та же проверка закрывает дыру с гиперссылками |

**При любой будущей синхронизации с апстримом эти два места нельзя затирать.**

Кроме того: убраны пять файлов CI оригинала (они собирают TrinityCore на серверах GitHub и
размечают его задачи), и история начинается с точки заимствования, а не с 2008 года. Все остальные
файлы совпадают с оригиналом байт в байт.

## Как читать историю

- коммиты **без пометки** — правки, взятые у TrinityCore; авторство их авторов сохранено;
- коммиты **`[algalon-local]`** — наши намеренные расхождения, которых в оригинале нет и не будет.

## Как собрать

Порядок сборки тот же, что у TrinityCore — их
[документация](https://trinitycore.info/en/install/Installation-Guide) применима целиком. Отличия
всего два, и оба обязательны:

```
cmake <источник> -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DSCRIPTS=static -DNOJEM=1
ninja
```

- **`-DNOJEM=1` обязателен.** Без него сборка падает на встроенном jemalloc: в C23 `void (*)()`
  означает `void (*)(void)`, и gcc 15 упирается в конфликт типов.
- **`revision_data.h` создаётся на этапе `cmake`, а не сборки.** После черри-пика перезапустите
  `cmake`, иначе свежесобранный сервер продолжит рапортовать прежнюю ревизию, и «какое ядро
  запущено» станет вопросом без ответа.

Понадобятся база мира TDB 1127.26011 и данные, извлечённые из клиента **ровно** этой версии. Ядро
другой версии клиента не обслуживает.

## Состояние

Ядро работает и обслуживает закрытый сервер. Правки из апстрима переносятся выборочно и по одной,
с проверкой каждой: апстрим ушёл на 12.0.0 всего через пятнадцать коммитов после нашей точки, и
всё, что написано поверх той основы, для 11.2.7 непригодно. Поэтому кода отсюда берётся мало и
осторожно — а вот исправления данных (квесты, существа, объекты) от смены дополнения почти не
зависят и переносятся куда свободнее.

Модуль QA-ботов, ради которого всё затевалось, живёт отдельно и сюда пока не входит.

## Лицензия

TrinityCore распространяется под **GPL-2.0**, и эта производная работа сохраняет ту же лицензию —
см. [COPYING](COPYING). Авторы кода, с которого всё начинается, перечислены в [AUTHORS](AUTHORS);
этот файл и указания об авторских правах внутри исходников остаются нетронутыми.

---

<details>
<summary><strong>English</strong></summary>

<br>

A World of Warcraft server core pinned at patch **11.2.7.65299**, started from a copy of
[TrinityCore](https://github.com/TrinityCore/TrinityCore) and developed forward as a separate
project.

> **This is not TrinityCore and does not speak for it.** Bugs found here are not reported there,
> and theirs are not ours. If you want a living, community-supported server, go to them.

### Why it exists

A testbed for the world. Bots play as real players — allowed only what a real client could send —
and when they hit something broken they **freeze in place** instead of working around it. A bot
standing still at a broken questgiver is the product: a bug report with coordinates. Anything that
skips, detours or teleports past a fault counts here as destroying evidence.

Hence the version: on 11.2.7 the world is measured and finite, so "should work" is a checkable
claim rather than a wish.

### What it stands on

| | |
|---|---|
| Upstream revision | [`8d31f000f7`](https://github.com/TrinityCore/TrinityCore/commit/8d31f000f77ff9c2e26d4a31e559943acf4eff03) — *TDB 1127.26011 - 2026/01/14* |
| World database | TDB **1127.26011** (official, released 2026-01-14) |
| Client | **11.2.7.65299** |

That revision is the last one compatible with TDB 1127.26011, which is why the project is anchored
there rather than at upstream's moving `master`. The tag `trinitycore-8d31f00` marks the point the
copy was taken: everything below it is other people's work, everything above it is ours.

### How it differs from upstream

**Exactly two deliberate divergences in code.** Both are marked `[algalon-local]` in history and
`// algalon-local` in the code, both were found by a deep audit of already-accepted changes, and
**both would have survived compilation and boot unnoticed** — they are behaviour, not typos:

| file | what and why |
|---|---|
| `UpdateFieldImpl.h` | Restores a workaround for an **11.2.x client bug**: the client replaces unsent values with zeroes, so everything must be sent. Upstream dropped it only after moving to 12.0 — their client moved on, ours did not. Without it a partial update blanks a player's talent loadout |
| `GuildPackets.h` | Guild string limits widened fourfold. The check counts **bytes** while storage counts **characters**: in Cyrillic a character is 2 bytes, so a rank name was silently truncated at the seventh letter. Reverting was not an option — the same check closes a hyperlink-injection hole |

**Any future upstream sync of those files must preserve them.**

Beyond that: five upstream CI files were dropped (they build TrinityCore on GitHub runners and
label its issues), and history starts at the import rather than in 2008. Every other file is byte
for byte upstream.

### Reading the history

- commits **without a marker** — changes taken from TrinityCore, with their authors intact;
- commits marked **`[algalon-local]`** — our deliberate divergences, which upstream does not have.

### Building

The build is TrinityCore's, and their
[documentation](https://trinitycore.info/en/install/Installation-Guide) applies in full. Two
differences, both mandatory:

```
cmake <source> -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DSCRIPTS=static -DNOJEM=1
ninja
```

- **`-DNOJEM=1` is required.** Without it the build dies inside the bundled jemalloc: C23 makes
  `void (*)()` mean `void (*)(void)`, and gcc 15 hits a type conflict.
- **`revision_data.h` is generated at `cmake` time, not build time.** Re-run `cmake` after
  cherry-picking, or a freshly built server still reports the old revision and "which core is
  running" becomes unanswerable.

You will need TDB 1127.26011 and data extracted from a client of **exactly** that version. The core
serves no other.

### Status

The core runs and serves a private realm. Upstream fixes are taken selectively, one at a time, each
verified: upstream crossed into 12.0.0 just fifteen commits after our anchor, and everything
written on that foundation is unusable for 11.2.7. So code is taken sparingly — while data fixes
(quests, creatures, gameobjects) are largely expansion-independent and travel much more freely.

The QA bot module this exists for lives separately and is not part of this repository yet.

### Licence

TrinityCore is licensed **GPL-2.0**, and this derivative keeps that licence — see
[COPYING](COPYING). The authors of the code this starts from are listed in [AUTHORS](AUTHORS); that
file, and the copyright notices inside the source files, stay exactly as they are.

</details>
