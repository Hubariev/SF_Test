@isTest
private class PersonAccountPrinterTest {

    @testSetup
    static void setupTestData() {
        RecordType personAccountRT = [SELECT Id FROM RecordType 
                                      WHERE SobjectType = 'Account' 
                                      AND DeveloperName = 'PersonAccount' 
                                      LIMIT 1];
        
        Account persAcc = new Account(
            RecordTypeId = personAccountRT.Id,
            LastName = 'Tester',
            PersonEmail = 'tester@example.com'
        );
        insert persAcc;
    }

    @isTest
    static void testPrintPersonAccounts() {
        Account persAccCheck = [SELECT Id, LastName FROM Account 
                           WHERE IsPersonAccount = TRUE 
                           LIMIT 1];
        System.assertNotEquals(null, persAccCheck, 'A Person Account should have been created in test setup.');
    
        Test.startTest();
        String jsonOutput = PersonAccountPrinter.printPersonAccounts();
        Test.stopTest();
        
        System.assert(jsonOutput.contains(String.valueOf(persAccCheck.Id)), 'JSON output should contain the account Id.');
        System.assert(jsonOutput.contains('Tester'), 'JSON output should contain the account LastName.');
    }
}