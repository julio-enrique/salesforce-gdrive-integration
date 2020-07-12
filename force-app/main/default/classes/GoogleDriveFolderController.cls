public with sharing class GoogleDriveFolderController {
    
    public static void init(Id recordId, String folderField){
        String sobjectType = 'Opportunity';
        String queryString = 'SELECT Id, ' + folderField + ' FROM  ' + sobjectType + ' WHERE Id=:recordId';
        Sobject result = Database.query(queryString);

        String folderUrl = String.valueof(result.get(folderField));
        String folderId = folderUrl;
        
        GoogleDriveApi_FolderFilesResult folderResult =  GoogleDriveApi.getFolderFiles(folderId, 100, null, null, null);


    }
}
