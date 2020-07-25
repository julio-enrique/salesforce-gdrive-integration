import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class GoogleDriveFolderItem extends NavigationMixin(LightningElement) {

    @api file;

    openFile(){
        if(this.file.mimeType.includes("folder")){
            this.dispatchEvent(new CustomEvent('folderselected', { detail: this.file.id }));
        }else{
            this[NavigationMixin.Navigate]({            
                type: 'standard__webPage',
                attributes: {
                    url: this.file.webViewLink
                }
                ,
            });
        }
    }
}