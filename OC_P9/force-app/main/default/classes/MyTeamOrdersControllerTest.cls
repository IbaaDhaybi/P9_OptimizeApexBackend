@isTest
private class MyTeamOrdersControllerTest {


     //Set up the data from TestDataFactory class
 @TestSetup
 static void setup(){
      Account acc = TestDataFactory.createAccount('AccountTest');
     List <Order> ordersList = TestDataFactory.createAccountWithOrders(50, acc.Id);
      // Set up the order status to 'Ordered'
     for( Order order : ordersList){
         order.Status = 'Ordered';
     }
         update ordersList;
    
    
        }   
        @isTest
        private static void TestAggregateResultList(){
        
            Test.startTest();
            MyTeamOrdersController controller = new MyTeamOrdersController();
            List<AggregateResult> totalOrdersByOwner = controller.aggregateResultList;
            Test.stopTest();
        
        //Assert that the list isn't empty
        System.assert(totalOrdersByOwner.size()>0);
    //50 orders * 100 unitprice = 5000
    System.assertEquals(5000, totalOrdersByOwner[0].get('ordAmount'));
 }
}
