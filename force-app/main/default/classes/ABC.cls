public class ABC1 {
	 public Customer__c customer{get;set;}
    public Boolean hideButton{get;set;}
    public Boolean customerForm{get;set;}
    public Boolean customerDetails{get;set;} 
    public Boolean customerRecord{get;set;}
    public List<Customer__c> customersData{get;set;} 
    public String customerId{get;set;}
    public ABC(){
        system.debug(customerId); 
        system.debug('New Test New Mahir Khan One First CHeck  FIrst Mahir Khan New One '); 
        customer = new Customer__c(); 
        customersData = new List<Customer__c>();
        customerForm = true; 
        customerDetails  = false;
        customerRecord = true; 
        customerId=ApexPages.currentPage().getParameters().get('Id');   
        if(!String.isEmpty(customerId)&& customerId.contains('clone')){
            customerId = customerId.removeEnd('clone'); 
           init(); 
        }
        if(!String.isEmpty(customerId)&& customerId.contains('newEdit')){
            customerId = customerId.removeEnd('newEdit'); 
            hideButton = false; 
            init(); 
        }
        customersData = [SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Gender__c, Is_Married__c, 
                         City__c FROM Customer__c]; 
    }
    private void init(){
        customer = [SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Gender__c, Is_Married__c, 
                    City__c FROM Customer__c Where Id=:customerId];
    }
    public pageReference Save(){
        pageReference pr = new pageReference('/apex/all_customers'); 
      
        if(customer.Email__c != '')
        {
               upsert customer;
        }
        else
        {
            ApexPages.Message msg = new   ApexPages.Message(ApexPages.Severity.WARNING,'Email Field Requerd '); 
            ApexPages.addMessage(msg); 
        }
        customerRecord = true;  
        return pr; 
    }
    public void SaveNew(){
        insert customer; 
        customer = new Customer__c();  
    }
    public void viewDetails(){
        System.debug('View Data');
        customer = [SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Gender__c, Is_Married__c, City__c FROM 
                    Customer__c Where Id=:customerId]; 
        System.debug(customer);
        customerRecord = false; 
        customerDetails = true;
    }  
    public pageReference customerDelete(){   
        pageReference pr = new  pageReference('/apex/all_customers');
        pr.setRedirect(true);
        customer = [SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Gender__c, Is_Married__c, City__c 
                    FROM Customer__c Where Id=:customerId]; 
        Delete customer; 
        return pr; 
        
    }
    public pageReference eidtDetails(){
        pageReference pr = new pageReference('/apex/customers?Id='+customerId +'newEdit');
        pr.setRedirect(true); 
        return pr;    
    }
    public pageReference cloneCustomer(){
        pageReference pr = new pageReference('/apex/customers?Id='+customerId+'clone'  );
        pr.setRedirect(true);  
        return pr; 
    }
    public pageReference Cancel(){
        pageReference pr = new pageReference('/apex/all_customers'); 
        pr.setRedirect(true); 
        return pr; 
    }
}