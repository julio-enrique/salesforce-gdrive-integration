import { LightningElement,wire,track,api } from 'lwc';
import init from '@salesforce/apex/GoogleDriveFolderController.init';
import getFolderContent from '@salesforce/apex/GoogleDriveFolderController.getFolderContent';
import doSearch from '@salesforce/apex/GoogleDriveFolderController.doSearch';

const DELAY = 300;

export default class GoogleDriveFolder extends LightningElement {

    //component params
    @api recordId;
    @api folderFieldName;
    folderId;
    
    searchKey = '';
    folderSize; 

    breadCrumb = [];
    
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
                this.folderId = result.folderId;
                this.breadCrumb.push(result.files);
                this.createPagination(result.files);
			})
			.catch(error => {
				this.error = error;
			});
    }

    goPreviousFolder(){
        this.createPagination(this.breadCrumb[this.breadCrumb.length-2]);
        this.breadCrumb.pop();
    }

    loadFolderEvent(event){
        const selectedFolder = event.detail;
        this.loadFolder(selectedFolder);

    }

    loadFolder(selectedFolder){
        //catch folder event
        getFolderContent({folderId: selectedFolder})
            .then(result => {
                //success
                console.log(result.files);
                this.folderSize = result.files.length;
                this.breadCrumb.push(result.files);
                this.createPagination(result.files);
                
			})
			.catch(error => {
				this.error = error;
		});
    }

    get folderLevels(){
        return this.breadCrumb.length > 1;
    }

    get paginationLabel(){
        return "Page " + (this.index + 1) + " of " + this.pages.length;
    }
    
    createPagination(files){
        this.temp = [];
        this.pages = [];
        this.index = 0;
        this.currentPage = [];

        for(var i = 0 ; i< files.length ; i++){
            console.log(files[i].id);
            if(this.temp.length < this.pageSize){
                this.temp.push(files[i]);
            }else{
                this.pages.push(this.temp);
                this.temp = new Array(files[i]);
            }
        }
        if(this.temp.length > 0){
            this.pages.push(this.temp);
        }
        console.log("pages length " + this.pages.length);
        console.log("last item length " + this.pages[this.pages.length-1].length);
        console.log("last page first item " + this.pages[this.pages.length-1][0]);
        this.currentPage = this.pages[0];
        this.index = 0;
    }

    getNextPage(){
        console.log("index " + this.index);
        console.log("pages length " + this.pages.length);
        console.log("last item length " + this.pages[this.pages.length-1].length);
        console.log("last page first item " + this.pages[this.pages.length-1][0]);        
        if(this.index < (this.pages.length-1)){
            this.index++;
            this.currentPage = this.pages[this.index];
        }

    }

    getPreviousPage(){
        console.log("pages length " + this.pages.length);
        console.log("last item length " + this.pages[this.pages.length-1].length);
        console.log("last page first item " + this.pages[this.pages.length-1][0]);        
        if(this.index > 0){
            this.index--;
            this.currentPage = this.pages[this.index];
        }
    }


}