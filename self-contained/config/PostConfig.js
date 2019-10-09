/**
 * Copyright (c) 2006-2019, JGraph Ltd
 * Copyright (c) 2006-2019, draw.io AG
 */
// null'ing of global vars need to be after init.js
window.VSD_CONVERT_URL = null;
window.EMF_CONVERT_URL = '/convert'; //This requires subscription with cloudconvert.com
window.ICONSEARCH_PATH = null;
EditorUi.enablePlantUml = true; //Enables PlantUML
DrawioFile.SYNC = 'none'; //Disable real-time sync
EditorUi.enableLogging = false; //Disable logging

//Treat this domain as a draw.io domain
App.prototype.isDriveDomain = function()
{
	return true;
}