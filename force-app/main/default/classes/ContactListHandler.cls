public with sharing class ContactListHandler {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getAllContacts() {
    	return [SELECT Id, Name, Email, Account.Name FROM Contact ORDER BY Name];
    }

    @AuraEnabled
    public static void deleteContacts(List<Contact> contactsToDelete) {
        try {
            delete contactsToDelete;
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}