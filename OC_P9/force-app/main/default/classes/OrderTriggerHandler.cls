public with sharing class OrderTriggerHandler {

    public static void updateAccountCA(List<Order> lstOrder){
        set<Id> setAccountId = new set<Id>();
        Map<id,Decimal> mapAccIdOrdAmount = new Map<Id,Decimal>();
        for(Order o: lstOrder){
            setAccountId.add(o.AccountId);
            if(! mapAccIdOrdAmount.containsKey(o.AccountId)){
                mapAccIdOrdAmount.put(o.AccountId,O.totalamount);
            }
            else{
                Decimal temp = mapAccIdOrdAmount.get(o.AccountId);
                mapAccIdOrdAmount.put(o.AccountId,o.totalAmount+temp);
            }
        }
        system.debug('####IDH map : ' + mapAccIdOrdAmount);
        List<Account> accost = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN : setAccountId];
        for(Account acc : accost){
            system.debug('####IDH CA : ' + acc.Chiffre_d_affaire__c);
            if(acc.Chiffre_d_affaire__c == null)
                acc.Chiffre_d_affaire__c = 0.0;
            acc.Chiffre_d_affaire__c += (decimal)mapAccIdOrdAmount.get(acc.Id);
        }
        update accost;
    }
        
}
