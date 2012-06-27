#!/usr/bin/python
import subprocess;
import os;
import sys;
import json;


class App():
	def __init__(self):
		path = os.path.dirname(sys.argv[0])
		path = os.path.abspath(path)
		fileObject = open(path+'/app-config.json')
		try:
		     fileContent = fileObject.read()
		finally:
		     fileObject.close()
		
		try:
			self.map = json.loads(fileContent)
		except (ValueError, AttributeError):
			print("your app-config.json is not a valid configuration file.")
			exit()
	
	def openApp(self, path):
		if os.path.isfile(path):
			subprocess.Popen(path)
		else:
			subprocess.Popen("explorer "+path)

	def getPathByKey(self, key):
		return self.map.get(key)

	def openKey(self, key):
		self.openApp(self.getPathByKey(key))
	
	def isValidKey(self, key):
		p = self.getPathByKey(key)
		if p:
			return os.path.exists(p)
		else:
			return False


if len(sys.argv) < 2:
	print "please type the application name want to launch."
	exit()


key = sys.argv[1]
args = sys.argv[2:]
app = App()

if app.isValidKey(key):
	app.openKey(key)
else:
	print "please type a valid application name want to lauch."
	exit()