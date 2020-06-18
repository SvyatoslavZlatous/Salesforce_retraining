@isTest
public class ContactListHandlerTest {
    private static final Integer REMAING_CONTACTS = 2;
    private static final String CLIENT_THROWN_EXCEPTION_BODY = 'Script-thrown exception';

    @isTest
    static void testGettingAllContact() {
        List<Contact> createdTestContacts = TestUtils.populateTestContacts();

        Test.startTest();
        List<Contact> allContacts = ContactListHandler.getAllContacts();
        Test.stopTest();

        System.assertEquals(createdTestContacts.size(), allContacts.size(),
             'The Contact Lists sizes are not equal');
    }

    @isTest
    static void testDeleteContacts() {
        List<Contact> createdTestContacts = TestUtils.populateTestContacts();
        List<Contact> contactsToDelete = TestUtils.generateContactsToDelete(createdTestContacts);

        Test.startTest();
        ContactListHandler.deleteContacts(contactsToDelete);
        Test.stopTest();

        List<Contact> remainingContacts = ContactListHandler.getAllContacts();
        System.assertEquals(REMAING_CONTACTS, remainingContacts.size(),
             'The Remaining Contacts List size should be equals to 2');
    }

    @isTest
    static void testDeleteContactsShouldThrowEception() {
        List<Contact> contactsToDelete = new List<Contact>();
        Contact testContact = TestUtils.createTestContact();
        Case testCase = TestUtils.createTestCase(testContact);
        contactsToDelete.add(testContact);

        try {
            ContactListHandler.deleteContacts(contactsToDelete);
        } catch(Exception e) {
            System.assert(e.getMessage().contains(CLIENT_THROWN_EXCEPTION_BODY),
                'The exception should thrown a client-side exception');
        }
    }
   
}
