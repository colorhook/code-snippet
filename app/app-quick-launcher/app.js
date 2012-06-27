#!/usr/local/bin/node
var path = require("path"),
	fs = require("fs"),
	child_process = require('child_process');

var App = function(){
	this.configFile = "app-config.json";
	this.initAppMap();
}
App.prototype = {
	constructor: App,

	openApp: function(path, args){
		console.log("open path:"+path);
	},

	initAppMap: function(){
		this.map = {
			"editplus" : "D:/Program Files/EditPlus3/editplus.exe"
		}
	},

	getAppPathByKey: function(key){
		var p = this.map[key];
		if(p == undefined){
			return key;
		}
		return path.normalize(p);
	},
	isValidKey: function(key){
		var p = this.getAppPathByKey(key);
		return path.existsSync(p);
	},
	parseArgs: function(){
		
		var key = process.argv[2], 
			args = process.argv.splice(3);
		return {
			key: key,
			args: args
		}
	}
}

//entry point
var app = new App(),
	keyAndArgs = app.parseArgs(),
	key = keyAndArgs.key,
	args = keyAndArgs.args;

if(app.isValidKey(key)){
	app.openApp(app.getAppPathByKey(key), args);
}else{
	console.log("The app key '"+key+"' you typed is not a valid key.");
}