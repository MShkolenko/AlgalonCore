-- Time Trials (55660): let the core offer it at max level, not at level one.
--
-- WHY. The quest carries QUEST_FLAGS_EX_AUTO_PUSH, and Player::PushQuests() hands such quests out
-- by itself -- from login, from GiveLevel, and from UpdateArea, which fires on EVERY area change.
-- A character walking a starting zone changes area constantly, so a level-2 player is handed a
-- max-level weekly within seconds of logging in, over and over. It cannot be refused and cannot
-- usefully be abandoned: dropping it only invites the next push.
--
-- Measured on this realm before the change: 97 abandons of 55660 in fifteen minutes, zero takes,
-- and 34 characters still holding it.
--
-- WHAT THIS DOES. CanTakeQuest() consults conditions of source type 19 (QUEST_AVAILABLE) through
-- Player::SatisfyQuestConditions, and PushQuests() calls CanTakeQuest before adding anything. So a
-- single availability condition stops the push at its source, with no code change: condition type
-- 27 (CONDITION_LEVEL) compares the player's level against ConditionValue1 using ConditionValue2
-- as the comparison, and 3 is COMP_TYPE_HIGH_EQ -- "level not below". MaxPlayerLevel here is 80.
--
-- The same shape is already used in this database: quests 8166 and 8167 are gated with type 27 and
-- comparison 2 ("level lower than"). This is the mirror of that.
--
-- SCOPE. The condition governs who is OFFERED the quest. Characters that already hold it keep it
-- until they drop it or are wiped; it occupies one of 25 log slots and nothing else.

DELETE FROM `conditions`
 WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 55660 AND `ConditionTypeOrReference` = 27;

INSERT INTO `conditions`
  (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
   `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
   `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`)
VALUES
  (19, 0, 55660, 0, 0, 27, 0, 80, 3, 0, 0, 0, 0,
   'Quest 55660 Time Trials is auto-pushed on every area change - offer it only at max level');
--
-- MAINTENANCE (Codex). The 80 is static: it does not follow MaxPlayerLevel. After a level-cap
-- raise the quest becomes available at 80 rather than at the new cap, so revisit this row with
-- the expansion data rather than assuming it tracks the config.
