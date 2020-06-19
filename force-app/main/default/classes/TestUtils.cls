public with sharing class TestUtils {
    
    public static List<Contact> createTestContacts() {
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 1; i <= 5; i ++) {
            Contact testContact = new Contact(firstName = 'Test', lastName = 'Contact' + i);
            testContacts.add(testContact);
        }
        return testContacts;
    }

    public static List<Contact> populateTestContacts() {
        List<Contact> contactsToInsert = createTestContacts();
        if(Contact.SObjectType.getDescribe().isCreateable()) {
            insert contactsToInsert;
        }
        return contactsToInsert;
    }

    public static Contact createTestContact() {
        Contact testContact = new Contact(firstName = 'test Contact', lastName = 'testContact');
        if(Contact.SObjectType.getDescribe().isCreateable()) {
            insert testContact;
        }
        return testContact;
    }

    public static Case createTestCase(Contact testContact) {
        Case testCase = new Case(contactId = testContact.Id);
        if (Case.SObjectType.getDescribe().isCreateable()) {
            insert testCase;
        }
        return testCase;
    }

    public static List<Contact> generateContactsToDelete(List<Contact> allContacts) {
        List<Contact> contactsToDelete = new List<Contact>();
        for(Integer i = 0; i < allContacts.size(); i++) {
            if(Math.mod(i, 2) == 0) {
                contactsToDelete.add(allContacts[i]);
            }
        }
        return contactsToDelete;
    } 
}
