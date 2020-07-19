public class GoogleDriveApi_File extends GoogleDriveApi_BaseWrapper{
    @AuraEnabled public String kind{get;set;}
    @AuraEnabled public String id{get;set;}
    @AuraEnabled public String name{get;set;}
    @AuraEnabled public String mimeType{get;set;}
    @AuraEnabled public String description{get;set;}
    @AuraEnabled public Boolean starred{get;set;}
    @AuraEnabled public Boolean trashed{get;set;}
    @AuraEnabled public Boolean explicitlyTrashed{get;set;}
    @AuraEnabled public Datetime trashedTime{get;set;}
    @AuraEnabled public String version{get;set;}
    @AuraEnabled public String webContentLink{get;set;}
    @AuraEnabled public String webViewLink{get;set;}
    @AuraEnabled public String iconLink{get;set;}
    @AuraEnabled public Datetime createdTime{get;set;}
    @AuraEnabled public Datetime modifiedTime{get;set;}
    @AuraEnabled public String teamDriveId{get;set;}
    @AuraEnabled public Boolean shared{get;set;}
    @AuraEnabled public String originalFilename{get;set;}
    @AuraEnabled public String fullFileExtension{get;set;}    
    @AuraEnabled public String fileExtension{get;set;}        

    //public List<String> parents{get;set;}
    //public String properties{get;set;}
    //public String appProperties{get;set;}
    
}