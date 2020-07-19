import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class GoogleDriveFolderItem extends NavigationMixin(LightningElement) {

    @api file;

    openFile(){
        // Navigate to the Account home page

        this[NavigationMixin.Navigate]({            
            type: 'standard__webPage',
            attributes: {
                url: this.file.webViewLink
            }
            ,
        });

    }
}