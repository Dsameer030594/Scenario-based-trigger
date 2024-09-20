trigger ContactTrigger on Contact (before insert, after insert) {

   /* if(Trigger.isInsert){
        if(Trigger.isBefore){
            
        }else if(Trigger.isAfter){
            //ContactTriggerHandler.createRelatedAccount(Trigger.new);
        }
    }  */
    
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            ContactTriggerHandler.setEmailWhenConisCreated(Trigger.new);
        }
        WHEN AFTER_INSERT{
             ContactTriggerHandler.createRelatedAccount(Trigger.new);
        }
    }
}