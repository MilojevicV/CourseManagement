trigger PhoneValidationTrigger on Contact (after insert, before update) {
    
    Contact newContact = Trigger.new[0];
    String ContactId = newContact.Id;
	//API_Key__mdt APIKey = API_Key__mdt.getInstance('Key');

    String Phone = newContact.Phone;
    String Country = newContact.MailingCountry;    
    if (Trigger.IsInsert){
        
        if(newContact.Phone!=null){
            
           PhoneValidationTest1.ApiCall(Phone,Country,ContactId);
        }
    }
    if(Trigger.isUpdate){
        Contact oldContact = Trigger.old[0];
    
    	if((newContact.Phone!=null) && (oldContact.Phone!=newContact.Phone)){
           PhoneValidationTest1.ApiCall(Phone,Country,ContactId);

        
    }
    } 
}