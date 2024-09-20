trigger AccountTrigger on Account (after insert) {

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            
        }else if(Trigger.isAfter){
            AccountTriggerHandler.createRelatedContactRecord(Trigger.new);
        }
    }
}