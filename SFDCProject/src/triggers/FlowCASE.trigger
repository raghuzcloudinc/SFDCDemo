trigger FlowCASE on case (after delete, after insert, after update, before delete, before insert, before update){  new WR_BPM.AbstractTrigger().execute();}