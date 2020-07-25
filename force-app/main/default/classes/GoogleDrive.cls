public with sharing class GoogleDrive {

    public static GoogleDriveObjectSettings__mdt getObjectMetadata(String objectName){
        return [SELECT ParentFolderId__c,FieldAPI_NameWithFolderId__c,FolderCreationField__c,Sobject__c from GoogleDriveObjectSettings__mdt where Sobject__c =:objectName][0];
    }

    public static void createRecordFolder(Id recordId,String description){
        String sobjectType = recordId.getSobjectType().getDescribe().getName();
        GoogleDriveObjectSettings__mdt mdt = getObjectMetadata(sobjectType);
        
        String name;
        String fieldName = mdt.FolderCreationField__c;
        if(fieldName == null){
            fieldName = 'Name';
        }
        name = String.valueof(Database.query('SELECT Id,' + fieldName + ' FROM ' + sobjectType + ' WHERE Id=:recordId')[0].get(fieldName));

        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_CreateFileResult cr = ga.createFile(name, description, new List<string>{mdt.ParentFolderId__c}, GoogleDriveApi.MIME_TYPE_FOLDER);
        
        if(cr.id != null){
            sObject sObj = Schema.getGlobalDescribe().get(sobjectType).newSObject();
            sObj.put('Id', recordId);
            sObj.put(mdt.FieldAPI_NameWithFolderId__c, cr.id);
            update sobj;
        }

    }

    public static GoogleDriveApi_File getFile(String fileId){
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_File result =  ga.getFile(fileId);
        return result;
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

    public static GoogleDriveApi_FileCommentsResult getFileComments(String fileId){
        GoogleDriveApi ga = new GoogleDriveApi();
        GoogleDriveApi_FileCommentsResult result =  ga.getFileComments(fileId);
        return result;
    }
}
