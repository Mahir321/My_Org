@RestResource(urlMapping='/VSRestClass/*')
global with sharing VSRestClass {
	@HttpGet
	global static void get(){
		RestRequest request = RestContext.request;
		String recordId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
	}
	@HttpPost
	global static void post(String name){
		Account acc=new Accout(name=:name);
		insert acc;
	}
	@HttpDelete
	global static void delete(){
		RestRequest request = RestContext.request;
		String recordId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
		sObject deleteRecord = [SELECT Id FROM sObject WHERE Id = :recordId];
		delete deleteRecord;
	}
	@HttpPut
	global static void put(String name,String recordId){
		Account acc=new Account(name=:name,Id=:recordId)
		update acc;
	}
	@HttpPatch
	global static void patch(){
		RestRequest request = RestContext.request;
		String recordId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
	}
}