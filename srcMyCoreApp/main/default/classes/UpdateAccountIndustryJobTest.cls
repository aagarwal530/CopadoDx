@isTest
private class UpdateAccountIndustryJobTest {

    @testSetup
    static void setup() {
        // Create test Accounts with Industry = 'Technology'
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i, Industry = 'Technology'));
        }
        insert accounts;
    }

    @isTest
    static void testExecute() {
        // Instantiate the job
        UpdateAccountIndustryJob job = new UpdateAccountIndustryJob();
        
        // Execute the job immediately using the Test.startTest() and Test.stopTest() methods
        Test.startTest();
        job.execute(null);
        Test.stopTest();
        
        // Query the updated Accounts
        List<Account> updatedAccounts = [SELECT Id, Industry FROM Account WHERE Industry = 'Software'];
        
        // Assert that the Industry field was updated to 'Software'
        System.assertEquals(10, updatedAccounts.size(), 'The number of accounts with Industry = "Software" should be 10.');
        for (Account acc : updatedAccounts) {
            System.assertEquals('Software', acc.Industry, 'The Industry field should be updated to "Software".');
        }
    }

    @isTest
    static void testJobScheduling() {
        // Schedule the job
        String cronExpression = '0 0 2 * * ?';
        String jobName = 'Test Account Industry Update Job';
        
        Test.startTest();
        System.schedule(jobName, cronExpression, new UpdateAccountIndustryJob());
        Test.stopTest();
        
        // Query the scheduled job
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE CronJobDetail.Name = :jobName LIMIT 1];
        
        // Assert that the job was scheduled correctly
        System.assertEquals(cronExpression, ct.CronExpression, 'The CRON expression should match the scheduled job.');
        System.assertEquals(0, ct.TimesTriggered, 'The job should not have been triggered yet.');
        System.assertNotEquals(null, ct.NextFireTime, 'The NextFireTime should be set.');
    }
}