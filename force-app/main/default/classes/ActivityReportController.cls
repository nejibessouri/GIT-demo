public with sharing class ActivityReportController {
    @AuraEnabled
    public static void saveActivityReport(Date startDate, Date endDate, String report) {
        Task newTask = new Task(
            Subject = 'Compte Rendu Activité',
            ActivityDate = startDate,
            Description = report,
            Status = 'Completed'
        );
        insert newTask;
    }
}