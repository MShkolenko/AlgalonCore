---
title: AlgalonCore
---

# AlgalonCore

Серверное ядро World of Warcraft, закреплённое на патче **11.2.7.65299**. Начато с копии
[TrinityCore](https://github.com/TrinityCore/TrinityCore) и развивается дальше как отдельный
проект. Код — на [GitHub](https://github.com/MShkolenko/AlgalonCore).

> Это не TrinityCore и не говорит от его имени.

## Зачем это существует

Полигон для проверки мира. Боты играют как настоящие игроки — им позволено только то, что мог бы
отправить настоящий клиент, — и, наткнувшись на поломку, **замирают на месте**, вместо того чтобы
её обойти. Бот, застывший у сломанного квестодателя, и есть результат работы: это отчёт об ошибке
с координатами.

На 11.2.7 мир измерим и конечен, поэтому «должно работать» — проверяемое утверждение, а не
пожелание. Ниже — то, что проверено.

## Что проверено

- **[Рабочий контент по зонам](coverage.html)** — какие зоны пройдены квестами, каким классом и
  насколько. Заполняется замером с сервера, а не со слов: строка появляется, когда конкретный
  класс **сдал** квест.

## Правило, по которому судится зона

Зона считается полностью рабочей в части квестов, когда **все классы выполнили все её квесты**.
Для стартовой зоны расы — только классы этой расы; для любой дальнейшей — все классы. Одна
пройденная цепочка ничего не доказывает: квест, который разбойник закрывает скрытностью, воин
может не пережить.

---

<details>
<summary><strong>English</strong></summary>

<br>

A World of Warcraft server core pinned at patch **11.2.7.65299**, started from a copy of
[TrinityCore](https://github.com/TrinityCore/TrinityCore) and developed forward as a separate
project. Source on [GitHub](https://github.com/MShkolenko/AlgalonCore).

> This is not TrinityCore and does not speak for it.

**Why it exists.** A testbed for the world. Bots play as real players — allowed only what a real
client could send — and when they hit something broken they **freeze in place** instead of working
around it. A bot standing still at a broken questgiver is the product: a bug report with
coordinates.

**What is verified.** [Working content by zone](coverage.html) — which zones have been played
through by quests, by which class, and how far. Filled from server measurements, never from
opinion: a row appears when a specific class has actually **turned in** a quest.

**The rule a zone is judged by.** A zone counts as fully working, in quest terms, when all classes
have completed all of its quests — for a race's own starting zone only that race's classes, for
every later zone absolutely all of them. One completed chain proves nothing: a quest a rogue closes
by stealth, a warrior may not survive.

</details>
