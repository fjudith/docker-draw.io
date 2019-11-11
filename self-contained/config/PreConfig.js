/**
 * Copyright (c) 2006-2019, JGraph Ltd
 * Copyright (c) 2006-2019, draw.io AG
 */
//Add CSP to prevent calls to draw.io
(function()
{
	try
	{
		var s = document.createElement('meta');
		
		s.setAttribute('content', 'default-src \'self\' https://apis.google.com https://docs.google.com https://code.jquery.com https://www.dropbox.com https://api.trello.com \'unsafe-inline\' \'unsafe-eval\'; connect-src \'self\' https://*.googleapis.com https://*.googleusercontent.com https://graph.microsoft.com https://*.1drv.com https://*.sharepoint.com; img-src * data:; media-src *; font-src *');
		s.setAttribute('http-equiv', 'Content-Security-Policy');

	  	var t = document.getElementsByTagName('meta')[0];
	  	t.parentNode.insertBefore(s, t);
	}
	catch (e)
	{
		// ignore
	}
})();

// Overrides of global vars need to be pre-loaded
window.EXPORT_URL = '/service/0'; //This points to ExportProxyServlet which uses the local export server at port 8000. 
							   //This proxy configuration allows https requests to the export server via Tomcat.
window.PLANT_URL = '/service/1';
window.DRAW_MATH_URL = 'math';
window.DRAWIO_CONFIG = null; //Replace with your custom draw.io configurations. For more details, https://desk.draw.io/support/solutions/articles/16000058316

//External service configurations. There are other configurations files needed also as follows

//Disable unsupported services
urlParams['db'] = '0'; //dropbox
urlParams['gh'] = '0'; //github
urlParams['gl'] = '0'; //gitlab
urlParams['tr'] = '0'; //trello

/**
 * Google Drive 
 */

//Google drive application id and client id for the editor
window.DRAWIO_GOOGLE_APP_ID = null;
window.DRAWIO_GOOGLE_CLIENT_ID = null;

//If you want to use the editor as a viewer also, you can create another app with read-only access. You can use the same info as above if write-access is not an issue. 
window.DRAWIO_GOOGLE_VIEWER_APP_ID = null;
window.DRAWIO_GOOGLE_VIEWER_CLIENT_ID = null;

//You will need also to configure the following files: google_client_id, google_client_secret, and google_client_redirect_uri

/**
 * Microsoft OneDrive 
 */

window.DRAWIO_MSGRAPH_CLIENT_ID = null;

//You will need also to configure the following files: msgraph_client_id, msgraph_client_secret, and msgraph_client_redirect_uri
