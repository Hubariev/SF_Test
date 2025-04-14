public with sharing class PersonAccountPrinter {

    public static String printPersonAccounts() {
        List<Account> personAccounts = [
            SELECT Id, Name, PersonContactId 
            FROM Account 
            WHERE IsPersonAccount = TRUE
        ];
        
        Map<Id, Account> mapIdToAccount = new Map<Id, Account>(personAccounts);

        String personAccountsOutput = JSON.serializePretty(mapIdToAccount);
        System.debug('Person Accounts in JSON: ' + personAccountsOutput);
        
        return personAccountsOutput;
    }
}