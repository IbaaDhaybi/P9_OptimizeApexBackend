public with sharing class AccountManager {
    
    public static void calculateAmount(List<Account> sAccountToRecalculate) {
       
        // Parcourir les comptes et leurs commandes(orders) associées (s'il existe)
        // pour calculer le chiffre d'affaire de Account
        for (Account account : sAccountToRecalculate) {
            account.Chiffre_d_affaire__c = 0;
            if (account.Orders != null && account.Orders.size() > 0) {
                for (Order order : account.Orders) {
                    account.Chiffre_d_affaire__c += order.TotalAmount;
                }
            }
        }
        // Mettre à jour la base de données
        update sAccountToRecalculate;
    }
}