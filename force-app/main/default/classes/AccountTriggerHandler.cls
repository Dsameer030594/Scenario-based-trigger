public class AccountTriggerHandler {

    //1. Whenever a record is inserted to the Account, Automatically inserted to the Contact
    
    public static void createRelatedContactRecord(List<Account> accList){
        
        List<Contact> conList = new List<Contact>();
        for(Account acc: accList){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);       
        }
        
        if(conList.size() >0){
            insert conList;
        }
    }
    
}