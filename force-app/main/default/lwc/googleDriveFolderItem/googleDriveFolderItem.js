import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class GoogleDriveFolderItem extends NavigationMixin(LightningElement) {

    @api file;

    openFile(){
        console.log('tes1');
        if(this.file.mimeType.includes("folder")){
            console.log('tes2');
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

    selectFolder(e){

    }
}