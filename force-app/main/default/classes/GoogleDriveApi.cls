/**
* The HelloWorld program implements an application that
* simply displays "Hello World!" to the standard output.
*
* @author  Julio Enrique
* @version 1.0
* @since   2020-07-09 
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
    public static GoogleDriveApi_FolderFilesResult getFolderFiles(String fileId, Integer maxresults, String orderBy, String pageToken){
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleAPI/drive/v3/files?q=\'' + fileId + '\'+in+parents&fields=*');
        HttpResponse response = new http().send(request); 
        System.debug(response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_FolderFilesResult record = (GoogleDriveApi_FolderFilesResult)JSON.deserialize(body, GoogleDriveApi_FolderFilesResult.class);
        return record;
    }

    /**
    * Performs a search in the drive's account
    */
    public static GoogleDriveApi_SearchResult search(String searchString){
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        System.debug('searchString' + searchString);
        request.setEndpoint('callout:GoogleAPI/drive/v3/files?q=' + searchString+'&fields=*');
        HttpResponse response = new http().send(request); 
        System.debug(response.getBody());
        String body = response.getBody();
        
        GoogleDriveApi_SearchResult record = (GoogleDriveApi_SearchResult)JSON.deserialize(body, GoogleDriveApi_SearchResult.class);
        return record;
    }    

    /**
    * Creates a folder/file
    */
    public static void createFile(String fileName){
        
    }

    /**
    * Given a gdoc (ppt,doc,spreadsheat) returns all the comments
    */
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