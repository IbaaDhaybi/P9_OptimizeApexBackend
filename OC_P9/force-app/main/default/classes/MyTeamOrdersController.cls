public with sharing class MyTeamOrdersController {

  public List<AggregateResult> aggregateResultList {get; set;}
 
  public MyTeamOrdersController() {
 
      aggregateResultList = new List <aggregateResult>();
      aggregateResultList = [SELECT COUNT(id) ordCount, 
                                    SUM(TotalAmount) ordAmount, 
                                    owner.Name ordName 
                                    FROM Order 
                                    WHERE Status = 'ordered' 
                                    GROUP BY owner.Name];
  }
 }
