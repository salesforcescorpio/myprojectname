@isTest(SeeAllData=true) 
public class MultiselectControllerNew_test{

 public static testMethod void testPositive() {
 MultiselectControllerNew mc = new MultiselectControllerNew();
 
 list<SelectOption> op = new list<SelectOption>();
 op.add(new selectOption('test','test'));
 mc.rightOptions  = op;
 mc.leftOptions  = op;
 mc.leftOptionsHidden  = 'op';
 
  mc.rightOptionsHidden = 'op';
 
 }
 
 
 }