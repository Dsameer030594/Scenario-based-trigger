public class ContactTriggerHandler {

    //2. Whenever a record is inserted to the Contact Automatically inserted to the Account.
    
    public static void createRelatedAccount(List<Contact> conList){
        
        List<Account> accList = new List<Account>();
        for(Contact con : conList){
            Account acc = new Account();
            acc.Phone = con.HomePhone;
            acc.Name = con.LastName;
            acc.Id =  con.AccountId;
            accList.add(acc);
        }
        insert accList;
    }

  // 4. Whenever contact is created with Department = 'CSE' then set email ='abc@gmail.com'
    public static void setEmailWhenConisCreated(List<Contact> conList){
        
        for(Contact con : conList){
            if(con.Department == 'CSE'){
                con.Email = 'abc@gmail.com';
            }
        }
    }
}