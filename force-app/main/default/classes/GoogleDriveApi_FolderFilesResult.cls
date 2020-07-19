public with sharing class GoogleDriveApi_FolderFilesResult extends GoogleDriveApi_BaseWrapper{
    @AuraEnabled public Boolean incompleteSearch{get;set;}
    @AuraEnabled public String folderId{get;set;}
    @AuraEnabled public List<GoogleDriveApi_File> files{get;set;}

}
