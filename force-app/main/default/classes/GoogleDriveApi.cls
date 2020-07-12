/**
* The HelloWorld program implements an application that
* simply displays "Hello World!" to the standard output.
*
* @author  Julio Enrique
* @version 1.0
* @since   2014-03-31 
*/
public class GoogleDriveApi {

    /**
    * Given the fileid this method returns the file details based on: https://developers.google.com/drive/api/v3/reference/files#resource
    */
    public static GoogleDriveApi_File getFile(String fileId){
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleAPI/drive/v3/files/' + fileId);
        HttpResponse response = new http().send(request); 
        System.debug(response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_File record = (GoogleDriveApi_File)JSON.deserialize(body, GoogleDriveApi_File.class);
        return record;
    }

    /**
    * Given the folderId this method returns its content
    */
    public static GoogleDriveApi_FolderFilesResult getFolderFiles(String fileId, Integer maxresults, String orderBy, String pageToken,String search){
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleAPI/drive/v3/files?q=\'folderid\'+in+parents');
        HttpResponse response = new http().send(request); 
        System.debug(response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_FolderFilesResult record = (GoogleDriveApi_FolderFilesResult)JSON.deserialize(body, GoogleDriveApi_FolderFilesResult.class);
        return record;        
    }

    public static GoogleDriveApi_FolderFilesResult search(String searchString){

        return null;        
    }    

    public static void createFile(String fileName){
        
    }

    public static GoogleDriveApi_FileCommentsResult getFileComments(String fileId, String nextPageToken){

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        String params = 'fields=*&maxResults=100';
        if(nextPageToken != null){
            params += ('&pageToken=' +nextPageToken);
        }
        
        request.setEndpoint('callout:GoogleAPI/drive/v3/files/' + fileId + '/comments?' + params);

        HttpResponse response = new http().send(request); 
        System.debug(response.getBody());
        String body = response.getBody();
        GoogleDriveApi_FileCommentsResult result = (GoogleDriveApi_FileCommentsResult)JSON.deserialize(body, GoogleDriveApi_FileCommentsResult.class);

        return result;
        
    }
    
}