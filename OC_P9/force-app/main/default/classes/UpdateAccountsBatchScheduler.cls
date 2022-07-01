global with sharing class UpdateAccountsBatchScheduler implements Schedulable{
    global void execute(SchedulableContext sc) {
        UpdateAccountProcessBatch uapb = new UpdateAccountProcessBatch();
        Id batchId = Database.executeBatch(uapb);
    }
}
