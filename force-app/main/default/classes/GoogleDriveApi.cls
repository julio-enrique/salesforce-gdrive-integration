/**
* Implementation of the google drive api callouts in apex.
*
* @author  Julio Enrique
* @version 1.0
* @since   2020-07-09 
*/
public class GoogleDriveApi {
    

    public static String MIME_TYPE_FOLDER = 'application/vnd.google-apps.folder';

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
    public GoogleDriveApi_CreateFileResult createFile(String fileName,String description, List<String> parents, String mimeType){
        request.setMethod('POST');
        request.setEndpoint(baseEndpoint + 'files');
        request.setHeader('Content-Type', 'application/json');

        System.debug('Endpoint: ' + request.getEndpoint());
        CreateFileRequest cfr = new CreateFileRequest(fileName, description, parents, mimeType);
        system.debug(JSON.serialize(cfr,true));
        request.setBody(JSON.serialize(cfr,true));
        HttpResponse response = new http().send(request); 
        System.debug('Response ' + response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_CreateFileResult record = (GoogleDriveApi_CreateFileResult)JSON.deserialize(body, GoogleDriveApi_CreateFileResult.class);     
        return record;   
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
    
    /**
    * Getters and setters
    */
    public void setFields(String fields){
        this.fields = fields;
    }
    public void setMaxResults(String maxResults){
        this.fields = maxResults;
    }
    public void setOrderBy(String maxResults){
        this.fields = maxResults;
    }    

    /**
    * Generate optional parameters for endpoint
    */
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



    public class CreateFileRequest {
        public String name{get;set;}
        public String description{get;set;}
        public List<String> parents{get;set;}
        public String mimeType{get;set;}

        public CreateFileRequest(String fileName, String description, List<String> parents, String mimeType){
            this.name = fileName;
            this.description = description;
            this.parents = parents;
            this.mimeType = mimeType;
        }
    }
}