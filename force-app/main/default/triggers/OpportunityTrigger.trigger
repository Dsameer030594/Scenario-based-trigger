trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, after delete, after undelete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        //OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.new);
        OpportunityTriggerHandler.createTaskSendEmailandscheduleaCall(Trigger.new, null);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.createTaskSendEmailandscheduleaCall(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isDelete && Trigger.isAfter){
       // OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.old);
    }
    if(Trigger.isUnDelete && Trigger.isAfter){
       // OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.new);
    }  
    /* 
Switch on Trigger.operationType{
when BEFORE_INSERT, BEFORE_UPDATE{

}
when AFTER_INSERT, AFTER_UPDATE{
OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.new); 
OpportunityTriggerHandler.createTaskSendEmailandscheduleaCall(Trigger.new, null);
OpportunityTriggerHandler.createTaskSendEmailandscheduleaCall(Trigger.new, Trigger.oldMap);
}
when AFTER_DELETE{
OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.old);
}
when AFTER_UNDELETE{
OpportunityTriggerHandler.rolllupTotalOppandAmountonAccount(Trigger.new);  
}
}  */
}