public with sharing class GoogleDriveApi_FileComment{
    public String id{get;set;}
    public String content{get;set;}
    public Boolean deleted{get;set;}
    public Author author{get;set;}
    public DateTime createdTime{get;set;}
    public DateTime modifiedTime{get;set;}

    public class Author {
        public String displayName{get;set;}
        public String photoLink{get;set;}
    }
}
