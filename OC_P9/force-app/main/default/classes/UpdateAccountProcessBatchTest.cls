@isTest
private class UpdateAccountProcessBatchTest {
    
    //Set up des données de la classe TestDataFactory 
    @TestSetup
    static void setup(){
        
        Account acc1 = TestDataFactory.createAccount('AccountTest1');
        List <Order> ordersList = TestDataFactory.createAccountWithOrders(20, acc1.Id);
        // changer le champs status des orders en 'Ordered'
        for( Order order : ordersList){
            order.Status = 'Ordered';
        }
        update ordersList;
        

        Account acc2 = TestDataFactory.createAccount('AccountTest2');
        List <Order> ordersList2 = TestDataFactory.createAccountWithOrders(50, acc2.Id);
        // changer le champs status des orders en 'Ordered'
        for( Order order : ordersList2){
            order.Status = 'Ordered';
        }
        update ordersList2;
         
        
        system.debug('####list2'+ordersList2);
        system.debug('####list1'+ordersList);
    }
    
    @isTest 
    static void UpdateAllAccountsBatchTest() {
        
        //Test du batch en ultilisant les données mises en place précédement 
        
        Test.startTest();
        
        UpdateAccountProcessBatch upAccs = new UpdateAccountProcessBatch();
        Id batchId = Database.executeBatch(upAccs);
        Test.stopTest();
        
        // Check New Acc CA
        Account acc1 = [SELECT ID, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest1' AND ID IN (SELECT AccountID FROM Order WHERE Status = 'Ordered')];
        Account acc2 = [SELECT ID, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest2' AND ID IN (SELECT AccountID FROM Order WHERE Status = 'Ordered')];

        //acc1 :  20 orders *100 unitPrice  = 2000
        //acc2 :  50 orders *100 unitPrice  = 5000
        
        System.assertEquals(2000, acc1.Chiffre_d_affaire__c);
        System.assertEquals(5000, acc2.Chiffre_d_affaire__c);
        
    } 
}