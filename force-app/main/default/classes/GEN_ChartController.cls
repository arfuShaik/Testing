public with sharing class GEN_ChartController {
  @AuraEnabled(cacheable=true)
  public static List<AggregateResult> getOpportunities() {
    return [
      SELECT StageName, SUM(Amount) amount, SUM(ExpectedRevenue) expectRevenue
      FROM Opportunity
      WHERE StageName != null
      GROUP BY StageName
      LIMIT 10
    ];
  }
}