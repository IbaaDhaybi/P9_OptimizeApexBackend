global class UpdateAccountProcessBatch implements Database.Batchable<sObject> {
    // Collection de batches d'enregistrement à exécuter
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator(
            [ SELECT Id, Chiffre_d_affaire__c , (SELECT TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered') ]
        );
           
    }

    // mettre à jour le champs Chiffre_d_affaire de tout ces accounts
    global void execute(Database.BatchableContext bc, List<Account> scope) {
               
        AccountManager.calculateAmount(scope);
    }

    // operations post-processing
    global void finish(Database.BatchableContext bc) {
    }
}
