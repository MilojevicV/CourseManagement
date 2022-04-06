public class PhoneValidationTest1 {
    
    @future (callout=true)
    public static void ApiCall(String Phone,String Country, String ContactId){
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        
        //String APIKey1 ='Key='+ APIKey;
        String APIKey1 ='Key='+'ZB74-BH72-GN78-RY48';
        String Phone1 ='Phone=' +Phone;
        String Country1 ='Country='+Country;
		
        //URL string == APIKey+Phone+Country
        String url = ('https://api.addressy.com/PhoneNumberValidation/Interactive/Validate/v2.20/json3.ws?'+APIKey1 +'&' + Phone1 +'&' + Country1);
        req.setEndpoint(url);
        req.setMethod('GET');
        HTTPResponse res = h.send(req);
        System.debug(res.getBody());
        Map <string,object> data = PhoneValidationTest1.Parsedata(res.getBody());
        if(data.size()>4){
                PhoneValidationTest1.ValidationSuccess(ContactId,data);
            } else {
                
                PhoneValidationTest1.ValidationError(ContactId,data);
            }
        
        
      
        
    }
    public static Map<String,Object> ParseData(string Data){
     Map <string,object> newData = (Map <string,object>) json.deserializeUntyped(data);
     List<Object> newData2 = (List<Object>) newData.get('Items');
     Map<string,Object> NewData3 = (Map <String,Object>) (newData2[0]);
     return NewData3;
  

    }
    public static void ValidationSuccess(String ContactId, map<string,object> data){
        
        Phone_Validation_Result__c data1=new Phone_Validation_Result__c();
        data1.Is_Valid__c=data.get('IsValid').toString();
        data1.Phone__c = ContactId;
        data1.CountryPrefix__c=(Integer)data.get('CountryPrefix');
        data1.NationalFormat__c=data.get('NationalFormat').toString();
        data1.NetworkCode__c=data.get('NetworkCode').toString();
        data1.NetworkCountry__c=data.get('NetworkCountry').toString();
        data1.NetworkName__c=data.get('NetworkName').toString();
        data1.NumberType__c=data.get('NumberType').toString();
        data1.PhoneNumber__c=data.get('PhoneNumber').toString();
        data1.RequestProcessed__c=data.get('RequestProcessed').toString();
        data1.RecordTypeId='0127Q000001ITvvQAG';
        system.debug(data);
        insert data1;
        
    }
    public static void ValidationError(String ContactId, map<string,object> data){

        Phone_Validation_Result__c data1=new Phone_Validation_Result__c();
		data1.Error__c=data.get('Error').toString();
        data1.Description__c=data.get('Description').toString();
        data1.Cause__c=data.get('Cause').toString();
        data1.Resolution__c=data.get('Resolution').toString();
        data1.Phone__c = ContactId;
        data1.RecordTypeId='0127Q000001ITwOQAW';
        insert data1;
		        
    }
}