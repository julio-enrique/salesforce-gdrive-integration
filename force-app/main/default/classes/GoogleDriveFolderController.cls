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
        
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_FolderFilesResult res =  ga.getFolderFiles(folderId);
        return res;

    }

    @AuraEnabled(cacheable=true)
    public static GoogleDriveApi_SearchResult doSearch(String folderId, String searchTerm){
        String encoded = EncodingUtil.urlEncode(searchTerm, 'UTF-8');
        
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_SearchResult searchResult =  ga.search('\'' + folderId + '\'+in+parents+and+name+contains+\'' + searchTerm+ '\'');
        return searchResult;

    }
}
