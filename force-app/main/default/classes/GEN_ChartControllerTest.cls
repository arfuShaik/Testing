/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class GEN_ChartControllerTest {

    @isTest
    static void testGetOpportunities() {
        // Create test Opportunities with various StageNames
        List<Opportunity> oppList = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            oppList.add(new Opportunity(
                Name = 'Test Opp ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 1000 + i * 100,
                ExpectedRevenue = 800 + i * 80
            ));
            oppList.add(new Opportunity(
                Name = 'Test Opp ' + i,
                StageName = 'Qualification',
                CloseDate = Date.today().addDays(30),
                Amount = 1500 + i * 100,
                ExpectedRevenue = 1200 + i * 80
            ));
        }
        insert oppList;

        // Call the method
        Test.startTest();
        List<AggregateResult> results = GEN_ChartController.getOpportunities();
        Test.stopTest();

        // Assert that the method returns data
        System.assertNotEquals(null, results);
        System.assert(results.size() > 0, 'Expected some results from aggregation');

        // Optional: print results for debug
        for (AggregateResult ar : results) {
            System.debug('Stage: ' + ar.get('StageName') +
                         ', Amount: ' + ar.get('amount') +
                         ', Expected Revenue: ' + ar.get('expectRevenue'));
        }
    }
}
