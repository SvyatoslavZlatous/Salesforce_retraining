public with sharing class Contacts extends fflib_SObjectDomain {
   
    public Contacts(List<Contact> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }

    public override void onBeforeDelete() {
        List<ContactRemovalHistory__c> historyContacts = new List<ContactRemovalHistory__c>();
        for(Contact deletedContact : (List<Contact>) Records) {
            if(String.isNotBlank(deletedContact.Email)) {
                historyContacts.add(
                    new ContactRemovalHistory__c(Name =  String.valueOf(DateTime.now()),
                     ContactEmail__c = deletedContact.Email));
            }
        }
        insert historyContacts;    
    }
}