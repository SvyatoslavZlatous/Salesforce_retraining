@isTest
public class ContactTriggerTest {

    private static final Integer NUMBER_OF_CONTACTS = 5;

    @testSetup
    private static void setup() {
        List<Contact> contactsToInsert = new List<Contact>();
        for(Integer i = 1; i <= NUMBER_OF_CONTACTS; i++) {
            Contact newContact = new Contact(firstName = 'Test' + i, lastName = 'test', 
                                            Email = String.format('test{0}@noreply.com', 
                                                                new String[] {String.valueOf(i)}));

            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }

    @isTest
    private static void testContactTriggerOnBeforeDelete() {
        List<Contact> contactsToDelete = [SELECT Name, Email FROM Contact WHERE Name LIKE 'Test_'];
        
        Test.startTest();
        delete contactsToDelete;
        Test.stopTest();

        List<ContactRemovalHistory__c> removedContacts = [SELECT Name, ContactEmail__c FROM ContactRemovalHistory__c
                                                        WHERE ContactEmail__c LIKE 'test%'];
                                                        
        System.assertEquals(contactsToDelete.size(), removedContacts.size(),
                             'The Removed Contacts sizes are not equal');
    }
}
