-- Fear No Evil: the monk variant (63447) can click the Injured Stormwind Infantry.
--
-- `quest_objectives` names nine quests with objective «Injured Soldier revived» on creature
-- 50047: 28806, 28808-28813, 29082 and 63447. The spellclick condition on 50047 -> 93072 listed
-- only the first eight (TDB 1127, rows from 4.3.4), so a monk carrying 63447 sends the click,
-- the core refuses it on the condition, no cast, no credit, and the quest can never complete.
-- Found 2026-09-12 on the live realm: one monk companion, 22 clicks in four minutes, zero
-- credits, while six companions of other classes had already been rewarded for their variant.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup`=50047 AND `SourceEntry`=93072 AND `ConditionValue1`=63447;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 50047, 93072, 0, 8, 9, 0, 63447, 0, 0, '', 0, 0, 0, '', 'Requires Fear No Evil quest active for spellclick');
