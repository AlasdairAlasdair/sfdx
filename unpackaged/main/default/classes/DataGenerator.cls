global class DataGenerator implements Schedulable {

    private Integer GetRandomNumber(Integer multiplier) {
        return Integer.valueof(Math.random() * multiplier);
    }

    private String GenerateRandomName() {
        Integer randomFirstNameIndex = GetRandomNumber(Names.FirstNames.size() - 1);
        Integer randomInitialIndex = GetRandomNumber(Names.Initials.size() - 1);
        Integer randomLastNameIndex = GetRandomNumber(Names.LastNames.size() - 1);        
        String randomName = Names.FirstNames[randomFirstNameIndex] + ' ' + Names.Initials[randomInitialIndex] + '. ' + Names.LastNames[randomLastNameIndex];
        return randomName;
    }
    
    private String GenerateRandomPhone() {
        String randomAreaCode = String.valueOf(GetRandomNumber(1000));
        String randomMiddleBit = String.valueOf(GetRandomNumber(1000));
        String randomLastBit = String.valueOf(GetRandomNumber(100000));
        return '(' + randomAreaCode + ') ' + randomMiddleBit + ' ' + randomLastBit;
    }
    
    private void CreateRandomAccount() {
        Account a = new Account();
        a.Name = GenerateRandomName();
        a.Phone = GenerateRandomPhone();
        insert a; 
    }
    
    private Account GetRandomAccount(){
        Integer accountsCount = [SELECT COUNT() FROM Account];
        Integer randomAccountIndex = Math.floor(Math.random() * accountsCount).intValue();
        return [SELECT Name FROM Account LIMIT 1 OFFSET :randomAccountIndex];
    }
    
    private void DeleteRandomAccount() {
        Account accountToDelete = GetRandomAccount();
        delete accountToDelete;
    }
    
    private void EditRandomAccount() {
        Account accountToEdit = GetRandomAccount();
        accountToEdit.Name = GenerateRandomName();
        accountToEdit.Phone = GenerateRandomPhone();
        update accountToEdit;
    }
    
    private void DoAction() {
        Integer actionIndex =  GetRandomNumber(3);
            
        switch on actionIndex {
            when 0 {
                CreateRandomAccount();
            }
            when 1 {
                DeleteRandomAccount();
            }
            when 2 {
                EditRandomAccount();
            }
            when else {
                System.debug('default');
            }
        }
    }
    
    global void execute(SchedulableContext ctx) {
        
        for (Integer i = 0; i < 15; i++) {
            DoAction();
        }
        
        String now = Datetime.now().format();
        System.debug('Data munger ran @ ' + now);
   }   
}