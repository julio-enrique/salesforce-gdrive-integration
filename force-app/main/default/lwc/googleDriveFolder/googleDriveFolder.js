import { LightningElement,wire,track,api } from 'lwc';
import init from '@salesforce/apex/GoogleDriveFolderController.init';
import doSearch from '@salesforce/apex/GoogleDriveFolderController.doSearch';

const DELAY = 500;

export default class GoogleDriveFolder extends LightningElement {

    //component params
    @api recordId;
    @api folderFieldName;
    
    searchKey = '';
    folderSize; 

    //pagination
    pageSize = 5;
    @track currentPage;
    @track index = 0;
    @track pages = [];

    error;
    
    connectedCallback(){
        this.loadData();
    }

    loadData(){
        init({recordId: this.recordId, folderField: this.folderFieldName})
            .then(result => {
                this.folderSize = result.files.length;
                this.createPagination(result.files);
			})
			.catch(error => {
				this.error = error;
			});
    }

    get paginationLabel(){
        return "Page " + (this.index + 1) + " of " + this.pages.length;
    }
    
    createPagination(files){
        this.temp = [];
        this.pages = [];

        for(var i = 0 ; i< files.length ; i++){
            if(this.temp.length < this.pageSize){
                this.temp.push(files[i]);
            }else{
                this.pages.push(this.temp);
                this.temp = new Array(files[i]);
            }
        }
        this.currentPage = this.pages[0];
        this.index = 0;
    }

    getNextPage(){
        if(this.index < this.pages.length){
            this.index++;
            this.currentPage = this.pages[this.index];
        }

    }

    getPreviousPage(){
        if(this.index > 0){
            this.index--;
            this.currentPage = this.pages[this.index];
        }
    }

    handleKeyChange(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
            doSearch({searchTerm:searchKey})
                .then(result => {
                    this.folderData.data = result;
                })
    
        }, DELAY);
    }
}