public with sharing class GoogleDriveInvocableCreateFolder {


    @InvocableMethod (Label='Create folder')
    public static void createFolder (List<Id> recordsIds){
        GoogleDrive.createRecordFolder(recordsIds[0], null);
    }
}
