public with sharing class GoogleDriveFolderController {
    
    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_FolderFilesResult init(Id recordId, String folderField){

        String sobjectType = recordId.getSobjectType().getDescribe().getName();
        String queryString = 'SELECT Id, ' + folderField + ' FROM  ' + sobjectType + ' WHERE Id=:recordId';
        Sobject result = Database.query(queryString);

        String folderId = String.valueof(result.get(folderField));
        
        GoogleDriveApi_FolderFilesResult folderResult =  GoogleDriveApi.getFolderFiles(folderId, 100, null, null);
        return folderResult;

    }

    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_FolderFilesResult getFolderContent(String folderId){
        
        GoogleDriveApi_FolderFilesResult folderResult =  GoogleDriveApi.getFolderFiles(folderId, 100, null, null);
        return folderResult;

    }

    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_SearchResult doSearch(String searchTerm){
        GoogleDriveApi_SearchResult searchResult =  GoogleDriveApi.search('name+contains+\'' + searchTerm+ '\'');
        return searchResult;

    }
}
