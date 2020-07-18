public with sharing class GoogleDriveApi_SearchResult {
    @AuraEnabled public Boolean incompleteSearch{get;set;}
    @AuraEnabled public List<GoogleDriveApi_File> files{get;set;}    
}
