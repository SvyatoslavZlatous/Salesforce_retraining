import { LightningElement, wire, track } from 'lwc';
import getAllContacts from '@salesforce/apex/ContactListHandler.getAllContacts';
import deleteContacts from '@salesforce/apex/ContactListHandler.deleteContacts';
import { refreshApex } from '@salesforce/apex';
import { showToast } from "c/utils";

const contactColumns = [
    { label : 'Contact Name', fieldName : 'Name' },
    { label : 'Contact E-mail', fieldName : 'Email' },
    { label : 'Account Name', fieldName : 'accountName'}
];

export default class ContactsList extends LightningElement {
    label = {
        Error: 'Error',
        Success: 'Success',
        Successful_Deleted: 'Successfully Deleted!'
    };

    selectedRecords = [];
    wiredContacts;
    @track contactData;
    @track contactColumns = contactColumns;
    @wire(getAllContacts)
    contactsList(result) {
        this.wiredContacts = result;
        if (result.data) {
             this.contactData = result.data.map(row=> Object.assign({
                'Id' : row.Id,
                'accountName': (row.Account != undefined) ? row.Account.Name : null,
                'Name' : row.Name,
                'Email': row.Email
            }));

        } else if (result.error) {
            showToast(this, this.label.Error, result.error.body.message, 'error');
            this.contactData = undefined;
        }
    }

    handleDelete(event) {
        deleteContacts({contactsToDelete: this.selectedRecords})
        .then(() => {
            showToast(this, this.label.Success, this.label.Successful_Deleted, 'success');
            this.deselectAllRows();
            return refreshApex(this.wiredContacts);
        })
        .catch(error => {
            showToast(this, this.label.Error, error.body.message, 'error');
        })
    }

    handleSelect(event) {
        this.selectedRecords = event.detail.selectedRows;
    }

    deselectAllRows() {
        this.template.querySelector('lightning-datatable').selectedRows = [];
    }
}
