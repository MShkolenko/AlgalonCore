-- Glacial Spike (199786) is scripted: it merges the stored Icicles into the spike (Mastery: Icicles, 76613).
DELETE FROM `spell_script_names` WHERE `spell_id`=199786 AND `ScriptName`='spell_mage_glacial_spike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(199786, 'spell_mage_glacial_spike');
