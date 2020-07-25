public with sharing class GoogleDrive {


    public static void createRecordFolder(Id recordId){
        String sobjectType = recordId.getSobjectType().getDescribe().getName();
        
    }

    public static GoogleDriveApi_FolderFilesResult getFolderFiles(String folderId){
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_FolderFilesResult result =  ga.getFolderFiles(folderId);
        return result;
    }

    public static GoogleDriveApi_SearchResult search(String searchTerm){
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_SearchResult searchResult =  ga.search(searchTerm);
        return searchResult;
    }


}
