public class OpportunityTriggerHandler {
    
    //3. Whenever Opportunity is created, deleted, undeleted. update total Opportunities and Total Amount on Account Object
    // here create Total Opportunities field and Total Amount field on Account Object
    
    public static void rolllupTotalOppandAmountonAccount(List<Opportunity> oppList){
        
        //To add Unique Opportunity in the set
        Set<Id> oppIds = new Set<Id>();
        List<Account> accList = new List<Account>();
        
        for(Opportunity opp : oppList){
            oppIds.add(opp.AccountId);
        }
        
        for(Account acc : [SELECT Id, Name, Total_Opportunities__c, Total_Opportunity_Amount__c,
                           (Select Id, AccountId, Amount from Opportunities) FROM Account Where ID IN: oppIds]){
                               Decimal TotalAmount = 0;
                               
                               for(Opportunity opp : acc.Opportunities){
                                   TotalAmount = TotalAmount + opp.Amount;  //or TotalAmount += opp.Amount;
                               }
                               acc.Total_Opportunity_Amount__c = TotalAmount;
                               acc.Total_Opportunities__c = acc.Opportunities.size();   
                               
                           }
        // Update Accounts
        if (!accList.isEmpty()) {
            update accList;
        }    
    }
    // Manish Choudhari : When an Opportunity is Marked as 'Closed Won' 
    // create a follow-up task for a sales team to engage with the customer, schedule a call, and send a thank you email.
    // Also update the next steps on Opportunity to 'Onboard a Contract'
    
    public static void createTaskSendEmailandscheduleaCall(List<Opportunity> oppList, Map<Id, Opportunity> oppOldMap){
       
         // Only proceed if oppOldMap is not null (i.e., not in an after insert context)
        if (oppOldMap != null) {
        Set<Id> oppIds = new Set<Id>();
        // Populate set with AccountIds for Opportunities whose StageName changed to 'Closed Won'
        for (Opportunity opp : oppList) {
            // Check if the Opportunity exists in the old map before accessing it
            if (oppOldMap.containsKey(opp.Id) && opp.StageName != oppOldMap.get(opp.Id).StageName && opp.StageName == 'Closed Won') {
                oppIds.add(opp.AccountId);
            }
        }
        
        List<Task> tkList = new List<Task>();
        // Fetch Opportunities to create tasks
        for (Opportunity opp : [SELECT Id, AccountId, StageName, NextStep FROM Opportunity WHERE AccountId IN :oppIds]) {
            if (oppIds.contains(opp.AccountId)) {
                opp.NextStep = 'Onboard a Contract';
                // Create multiple tasks for each opportunity
                Task tk1 = new Task();
                tk1.Subject = 'Engage with Customer';
                tk1.WhatId = opp.Id;
                tkList.add(tk1);
                
                Task tk2 = new Task();
                tk2.Subject = 'Schedule a call';
                tk2.WhatId = opp.Id;
                tkList.add(tk2);
                
                Task tk3 = new Task();
                tk3.Subject = 'Send a Thank you Email';
                tk3.WhatId = opp.Id;
                tkList.add(tk3);
            }
        }
        // Insert all tasks in a single DML operation
        if (!tkList.isEmpty()) {
            insert tkList;
        } 
    }
    }
    }