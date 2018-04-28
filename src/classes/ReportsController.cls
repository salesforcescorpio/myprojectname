public class ReportsController {
    public list<String> ReportIds {get;set;}

    public ReportsController (){
    list<String> reportNames = new list<String>();
    reportNames.add('Account Summary Report');
    reportNames.add('Lead Summary Report');
    
    ReportIds  = new list<String> ();
    list<report> allreports = [SELECT Id, Name, DeveloperName, NamespacePrefix FROM Report where Name in : reportNames];
    
    for(report each:allreports ){
    
    ReportIds.add(each.id);
    }
    
    }
}