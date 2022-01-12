#include "ofMain.h"
#include "ofApp.h"

//========================================================================
int main( ){
    ofGLWindowSettings settings;
    settings.width = 640;
    settings.height = 360;
    settings.setGLVersion(3,2);
	ofCreateWindow(settings);
	ofRunApp(new ofApp());
}
