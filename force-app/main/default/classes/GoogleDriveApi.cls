/**
* The HelloWorld program implements an application that
* simply displays "Hello World!" to the standard output.
*
* @author  Julio Enrique
* @version 1.0
* @since   2020-07-09 
*/
public class GoogleDriveApi {
    
    //set fields on format: files/id,files/name,...
    private String fields{get;set;}
    private Integer maxResults{get;set;}
    private String orderBy{get;set;}

    private HttpRequest request {get;set;}
    private String baseEndpoint{get;set;}

    public GoogleDriveApi(){
        request = new HttpRequest();
        this.baseEndpoint = 'callout:GoogleAPI/drive/v3/';
        this.fields = '*';
    }

    /**
    * Given the fileid this method returns the file details based on: https://developers.google.com/drive/api/v3/reference/files#resource
    */
    public GoogleDriveApi_File getFile(String fileId){
        request.setMethod('GET');
        request.setEndpoint(baseEndpoint + 'files/' + fileId + '?' + generateOptionalParameters());
        System.debug('Endpoint: ' + request.getEndpoint());
        HttpResponse response = new http().send(request); 
        System.debug('Response ' + response.getBody());
        String body = response.getBody();
        GoogleDriveApi_File record = (GoogleDriveApi_File)JSON.deserialize(body, GoogleDriveApi_File.class);

        return record;
    }

    /**
    * Given the folderId this method returns its content
    */
    public GoogleDriveApi_FolderFilesResult getFolderFiles(String fileId){
        request.setMethod('GET');
        request.setEndpoint(baseEndpoint + 'files?q=\'' + fileId + '\'+in+parents&' + generateOptionalParameters());
        System.debug('Endpoint: ' + request.getEndpoint());
        HttpResponse response = new http().send(request); 
        System.debug('Response ' + response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_FolderFilesResult record = (GoogleDriveApi_FolderFilesResult)JSON.deserialize(body, GoogleDriveApi_FolderFilesResult.class);
        return record;
    }

    /**
    * Performs a search in the drive's account
    */
    public GoogleDriveApi_SearchResult search(String searchString){
        request.setMethod('GET');
        request.setEndpoint(baseEndpoint + 'files?q=' + searchString + '&' + generateOptionalParameters());
        System.debug('Endpoint: ' + request.getEndpoint());
        HttpResponse response = new http().send(request); 
        System.debug('Response ' + response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_SearchResult record = (GoogleDriveApi_SearchResult)JSON.deserialize(body, GoogleDriveApi_SearchResult.class);
        return record;
    }    

    /**
    * Creates a folder/file
    */
    public void createFile(String fileName){
        
    }

    /**
    * Given a gdoc (ppt,doc,spreadsheat) returns all the comments
    */
    public GoogleDriveApi_FileCommentsResult getFileComments(String fileId){
        request.setMethod('GET');
        request.setEndpoint(baseEndpoint + 'files/' + fileId + '/comments?' + generateOptionalParameters());
        System.debug('Endpoint: ' + request.getEndpoint());

        HttpResponse response = new http().send(request); 
        System.debug('Response ' + response.getBody());
        String body = response.getBody();
        GoogleDriveApi_FileCommentsResult result = (GoogleDriveApi_FileCommentsResult)JSON.deserialize(body, GoogleDriveApi_FileCommentsResult.class);

        return result;
        
    }
    

    public void setFields(String fields){
        this.fields = fields;
    }
    public void setMaxResults(String maxResults){
        this.fields = maxResults;
    }
    public void setOrderBy(String maxResults){
        this.fields = maxResults;
    }    

    private String generateOptionalParameters(){
        String result = '';
        if(fields != null){
            result += 'fields=' + fields;
        }

        if(maxResults != null){
            result += 'maxResults=' + maxResults;
        }        

        if(orderBy != null){
            result += 'orderBy=' + orderBy;
        }
        System.debug('opt params: ' + result);
        return result;
    }    
}