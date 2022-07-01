@isTest
private class UpdateAccountCATest {
    
    @TestSetup
    
    //Creation de  données fromde la classe TestDataFactory pour un account et 200 orders
    static void setup(){
        Account acc = TestDataFactory.createAccount('AccountTest');
        List <Order> ordersList = TestDataFactory.createAccountWithOrders(200, acc.Id);  
    }
    
    @isTest
    static void MontantOfOneAccountWithSeveralOrders(){
        
        List <Order> ordersList = [SELECT AccountId, ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Account.Name = 'AccountTest'];
        
        Decimal total =0; 
        Decimal netToTest =0;
        Decimal netShip = 0;       
        
        for(Order ord : ordersList) {
            ord.Status = 'Ordered';
            ord.ShipmentCost__c= 10;           
            
            system.debug('shipcost'+ ord.ShipmentCost__c);
            // avoir le total amount de ShipmentCost pour tout les orders
            
            total += ord.TotalAmount;
            netShip += ord.ShipmentCost__c ; 
            netToTest = total - netShip;
        }
        
        Test.startTest();
        update ordersList; 
        Test.stopTest();  
        
        //  (200 orders * 100 unitprice)- 200*10 = 18000
        
        System.assertEquals(20000, total) ; 
        System.assertEquals(2000, netShip) ;
        System.assertEquals(18000 ,netToTest);  
    } 
    
}