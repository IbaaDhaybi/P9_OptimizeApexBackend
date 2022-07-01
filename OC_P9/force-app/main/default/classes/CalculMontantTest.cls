@isTest
private class CalculMontantTest {
    
    @TestSetup
    //Set up des données d'un accountet une commande(order) de la classe TestDataFactorry 
    static void setup() {
        Account acc = TestDataFactory.createAccount('AccountTest');
        
    }
    
    @isTest
    static void NetAmountForOneAccountOneOrderTest() {
 
        Account acc = [SELECT Id FROM Account WHERE Account.Name = 'AccountTest'];
        Product2 product2 = TestDataFactory.createProduct();
        PricebookEntry priceBookEntry = TestDataFactory.createPriceBookEntry(product2.Id, 100);
        Contract contract = TestDataFactory.createContract(acc.id);
        contract.Status = 'Activated';
        update contract;
        Order order = TestDataFactory.createOrder(acc.Id, contract.Id);
        
        order.shipmentCost__c = 100.00;
        update order;
        decimal netToTest;
        
        
        Test.startTest();
        OrderItem orderItem = TestDataFactory.createOrderItem(order.Id, product2.Id, 1, 1000, priceBookEntry.Id);
        Order orderToTest = [SELECT TotalAmount, shipmentCost__c FROM Order WHERE Id = :order.Id ];
        netToTest = orderToTest.TotalAmount - orderToTest.shipmentCost__c;
        Test.stopTest();
        
        //900 = 1 Order * 1000 UnitPrice - 100 shipmentCost
        Order netCalculated = [SELECT NetAmount__c FROM Order];
        System.assertEquals( netCalculated.NetAmount__c, netToTest);
    }
}
