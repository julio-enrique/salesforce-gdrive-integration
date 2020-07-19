public virtual class GoogleDriveApi_BaseWrapper {
    @AuraEnabled public Error error{get;set;}

    public class Error{
        @AuraEnabled public List<ErrorItem> errors{get;set;}
        @AuraEnabled public String code{get;set;}
        @AuraEnabled public String message{get;set;}
    
    }

    public class ErrorItem {
        @AuraEnabled public String domain{get;set;}
        @AuraEnabled public String reason{get;set;}
        @AuraEnabled public String message{get;set;}
        @AuraEnabled public String locationType{get;set;}
        @AuraEnabled public String location{get;set;}
    }
}
