# Salesforce with Google Drive integration
The objective of this project aims to build an Apex Wrapper of the Google Drive REST API with a library of apex services and components.

![Google Drive Folder](https://github.com/julio-enrique/salesforce-gdrive-integration/blob/master/screenshot.png)

## Getting started

### Prerequisites
A Google account and Salesforce Org in any version.

### Installing

1. Create an app in the google cloud console that allows you to connect from a third party app (in this case Salesforce).
2. In Salesforce, create an Auth. Provider and Named credentials with the information generated from the Google Cloud app.
3. Add https://googleapis.com to remote site settings
- This excelent post by [SalesforceProfs](https://salesforceprofs.com/salesforce-to-google-rest-api-integration/) explains very well and in detail all these steps.  - 
4. Install this source code in your org.
5. Ready to go!

### Using this project
Use this project as a starting point when working with the drive API. 
![Solution components](https://github.com/julio-enrique/salesforce-gdrive-integration/blob/master/Solution%20components.png)

#### Name credentials and data source 
Declarative components to create the connection
#### Google Drive API
Is the API Wrapper. 
#### Google Drive
#### Components layer


