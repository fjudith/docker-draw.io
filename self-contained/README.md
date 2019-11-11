This docker compose file runs draw.io diagram editor without depending on any draw.io online services (e.g., export service, plantUml, ...) and with support of Google Drive, Microsoft OneDrive, ...

### Adding fonts to improve generated PDFs and images

The docker-compose file bind the `fonts` folder into the running container system fonts.

The best option for Windows users is to copy the contents of `Windowsdrive:/Windows/Fonts` into `fonts` folder. These fonts are copyrighted and cannot be re-distributed freely.

# Configuration

## Google Drive

You will need to create a project at [Google API Console](https://console.developers.google.com/apis) and create [Credentials](https://console.developers.google.com/apis/credentials) of type "Create OAuth client ID" -> Web Application. This option will be disabled until you create "OAuth consent screen" from the link in warning message bar. In the "OAuth consent screen" configuration, enter the "Application name" and "Authorized domains". In the "Create OAuth client ID" configuration, enter the required information and note that "Authorized redirect URIs" is `[your-draw.io-hostname]/google`. For example, if you host draw.io at `https://drawio.example.com`, then "Authorized redirect URIs" whould be `https://drawio.example.com/google` and "Authorized JavaScript origins" would be `https://drawio.example.com`.

Copy the values of the generated "Client ID" and "Client secret" whould should be added in the `google_client_id` and `google_client_secret` files respectively [in `config` folder]. Also, in `PreConfig.js` file, change the values of `window.DRAWIO_GOOGLE_APP_ID` and `window.DRAWIO_GOOGLE_CLIENT_ID`. APP ID is the number before the dash in the CLIENT ID. For example, if CLIENT ID is `123456789-abc...`, then APP ID is `123456789`

In `google_client_redirect_uri`, enter the redirect URI used in Google's API configuration. For example, `https://drawio.example.com/google`

## Microsoft OneDrive

You will need to create and application in order to use MS Graph APIs. Follow the information on [how to register your app](https://docs.microsoft.com/en-us/graph/auth-register-app-v2) and [how to use the APIs](https://docs.microsoft.com/en-us/graph/use-the-api).

Once you registered your application, from Microsoft Azure UI, select your new app, then "Authentication". From Authentication, enter your redirect URIs. draw.io requires two redirect URIs `[your-draw.io-hostname]/microsoft` and `[your-draw.io-hostname]/onedrive3.html`. For example, if you host draw.io at `https://drawio.example.com`, then redirect URIs would be `https://drawio.example.com/microsoft` and `https://drawio.example.com/onedrive3.html`

In "Advanced settings" on the same page, enable "Access tokens" and "ID tokens" check boxes. To get the "Client secret", select "Certificates & secrets" page from the menu, then click "+ New client secret" button. Finally, from the "Overview" page in the menu, you can find the "Application (client) ID". 

Copy the client ID and secret to `msgraph_client_id` and `msgraph_client_secret` files respectively. Also, in `PreConfig.js` file, change the values of `window.DRAWIO_MSGRAPH_CLIENT_ID` to the client ID. 

In `msgraph_client_redirect_uri`, enter the redirect URI that ends with `/microsoft`. For example, `https://drawio.example.com/microsoft`

## EMF Converter

This service is currently used by VSDX importer for converting EMF files in VSDX files. If you don't plan to use VSDX importer or your VSDX files don't contain EMF files, then this service is not important to you.

This service is based on [Cloud Convert](http://cloudconvert.com). You will need to register for an account and copy the API KEY to `cloud_convert_api_key` file. We use API **V1** API KEY.