public with sharing class OrderItemHandler {
    public static void calculMontant (List<OrderItem> lstOrderItem){
        
        Set<Id> orderIds = new Set<Id>();
        for (OrderItem orderItems : lstOrderItem){
            orderIds.add(orderItems.OrderId);
        }
        list<OrderItem> lstFullOrderItems = [SELECT OrderId, UnitPrice FROM OrderItem WHERE OrderId IN: orderIds];
        Map<Id,Decimal> mapOrderTotal = new Map<Id,Decimal>();
        for (OrderItem oI: lstFullOrderItems ){
            if (mapOrderTotal.get(oI.OrderId)== null){
                mapOrderTotal.put(oI.OrderId, oI.UnitPrice);
            }
            else {
                Decimal temp = mapOrderTotal.get(oI.OrderId);
                mapOrderTotal.put(oI.OrderId, oI.UnitPrice + temp);
            }
        }
        list<Order> lstOrder = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order WHERE Id IN : orderIds];
        for(Order o : lstOrder){
            
            Decimal shipCost;
          
            if(o.ShipmentCost__c == null){
                shipCost = 0.0;
            } else {
                shipCost = o.ShipmentCost__c;
            }

            o.NetAmount__c = mapOrderTotal.get(o.Id) - shipCost;
        }
        update lstOrder;
                
    }
}
