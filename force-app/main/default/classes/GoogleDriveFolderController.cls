public with sharing class GoogleDriveFolderController {
    
    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_FolderFilesResult init(Id recordId, String folderField){

        String sobjectType = recordId.getSobjectType().getDescribe().getName();
        String queryString = 'SELECT Id, ' + folderField + ' FROM  ' + sobjectType + ' WHERE Id=:recordId';
        Sobject result = Database.query(queryString);

        String folderId = String.valueof(result.get(folderField));
        GoogleDriveApi_FolderFilesResult res = getFolderContent(folderId);
        res.folderId = folderId;
        return res;
    }

    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_FolderFilesResult getFolderContent(String folderId){
        
        return GoogleDrive.getFolderFiles(folderId);

    }

    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_SearchResult doSearch(String folderId, String searchTerm){
        String encoded = EncodingUtil.urlEncode(searchTerm, 'UTF-8');
        String search = '\'' + folderId + '\'+in+parents+and+name+contains+\'' + searchTerm+ '\'';
        
        return GoogleDrive.search(searchTerm);

    }
}
