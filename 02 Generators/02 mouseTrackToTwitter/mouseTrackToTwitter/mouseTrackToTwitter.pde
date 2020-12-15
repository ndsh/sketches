// trackScreen by Colin Owens
// Using JAVA mouseInfo for a bit of hackiness
// Use to your heart's content with attribution
// 2010
// @ can be found on GitHub:
// https://gist.github.com/colinowens/3816229

/** todo
# vorzeitiges ende
# 
# typography
# mouse clicks zählen
# ------ */

import java.awt.*;
import java.applet.*;
import java.awt.event.*;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;

import java.util.*;
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;

colorDude dude = new colorDude();

Twitter twitter;
File file;

PFont bebas220;
PFont bebas48;
int colorWheel;

color backgroundColor = #e1e1e1;
color foregroundColor = #323232;
color foregroundColor2 = #ff0000;

 
// import processing.pdf.*;

String settingsValues[];
String saveSettings[];

int mapCounter;
 
PGraphics buffer;
 
Point mouse;

boolean recording = false;
 
float weight = .05;
int lastX, lastY;

 
int clicked = 0;

boolean debug = false;

/* time */
int s;
int m;
int h;
long currentMillis = 0;
long previousMillis = 0;
long interval = 3000;
long idleTime = 0;
long movingTime = 0;
long idleInterval = 0;
boolean isIdle = false;
boolean isMoving = false;
boolean isSaved = false;
long runningTime = 0;
long amountX = 0;
long amountY = 0;

int mTime = 60; // time mouse has to move before record starts again in seconds
int iTime = 300; // time until records stops in seconds
 
void setup() {
	s = second();  // Values from 0 - 59
	m = minute();  // Values from 0 - 59
	h = hour();    // Values from 0 - 23
	colorMode(HSB, 360, 100, 100);
	/* ##### twitter setup */
	ConfigurationBuilder cb = new ConfigurationBuilder();

	cb.setOAuthConsumerKey("+++++YOUR TWITTER CONSUMER KEY++++");
	cb.setOAuthConsumerSecret("+++ YOUR CONSUMER SECRET +++++");
	cb.setOAuthAccessToken("++++ YOUR ACCESS TOKEN ++++");
	cb.setOAuthAccessTokenSecret("+++ YOUR ACCESS TOKEN SECRET ++++");

	TwitterFactory tf = new TwitterFactory(cb.build());
	twitter = tf.getInstance();
	/* ##### twitter setup end */

	settingsValues = loadStrings("settings.txt");
	saveSettings = settingsValues;
	mapCounter = int(settingsValues[0]);
	background(backgroundColor);
	// size(displayWidth, displayHeight);
	size(10, 10, JAVA2D);
	// size(displayWidth, displayHeight, P2D);
	buffer = createGraphics(displayWidth, displayHeight, JAVA2D);
	bebas220 = loadFont("BebasNeueLight-220.vlw");
	bebas48 = loadFont("BebasNeueLight-48.vlw");
	mouse = MouseInfo.getPointerInfo().getLocation();
	 
	lastX = mouse.x;
	lastY = mouse.y;
	buffer.smooth();
	println("I'm running");

	colorWheel = int(map(h, 0, 23, 0, 360));
	dude.makePretty(h,m,s);
	buffer.beginDraw();
	buffer.background(backgroundColor);
	buffer.endDraw();
}
 
void draw() {
	s = second();
	m = minute();
	h = hour();
	// h++;
	// h%=23;

	colorWheel = int(map(h, 0, 23, 0, 360));
	noStroke();
	// fill(0, 10);
	
	// background(backgroundColor);
	// fill(foregroundColor);
	// rect(250,250,50,50);
	// fill(foregroundColor2);
	// rect(550,250,50,50);
	mouse = MouseInfo.getPointerInfo().getLocation();
	if(millis() - currentMillis >= 1000) {
		idleTime += 1;
		movingTime += 1;
		currentMillis = millis();
		if(isMoving) runningTime += 1;
	}

	if(idleTime >= iTime) {
		if(!isSaved) {
			mapCounter++;
			buffer.beginDraw();
				int rando = int(random(2));
				if(rando == 0) buffer.fill(foregroundColor, random(100));
				else buffer.fill(foregroundColor2, random(100));
				float dWidth = ((displayWidth/12)*random(12));
				float dHeight = ((displayHeight/12)*random(12));
				buffer.textFont(bebas220, 220);
				buffer.text(addZeros(mapCounter), dWidth, dHeight);
				buffer.textFont(bebas48, 48);
				buffer.text("mouseMap #"+ addZeros(mapCounter), dWidth, dHeight+20);
				buffer.text(runningTime + " second"+(runningTime>1?"s":" "), dWidth, dHeight+55);
				buffer.text(addZeros(h) +":"+addZeros(m)+":"+addZeros(s), dWidth, dHeight+95);
			buffer.endDraw();
			buffer.save("maps/map"+mapCounter+".png");
			file = new File("/Volumes/Macintosh HD/Users/julianhespenheide/Programming/Processing/mouseTrackToTwitter/maps/map"+mapCounter+".png");
			String toTweet = "#mouseMap ("+addZeros(mapCounter)+") at ("+ addZeros(h) +":"+addZeros(m)+":"+addZeros(s)+"). running time ("+runningTime+") second"+(runningTime>1?"s":" ")+". #processing #visualization";
			tweet(toTweet, file);
			saveSettings[0] = ""+mapCounter;
			saveStrings("settings.txt", saveSettings);
			isSaved = true;
			buffer.beginDraw();
			buffer.background(backgroundColor);
			buffer.endDraw();

		}
		dude.makePretty(h,m,s);
		dude.spinWheel(colorWheel);
		isIdle = true;
		isMoving = false;
		movingTime = 0;
		background(backgroundColor);
		weight = .05;
	}
	if(lastX != mouse.x && lastY != mouse.y) {
		idleTime = 0;
		isIdle = false;
		if(movingTime >= mTime) {
			isMoving = true;
			isSaved = false;
		}
	}

	if(debug) {
		pushStyle();
		fill(0);
		rect(0, 0, 200, 60);
		fill(255);
		text("isIdle: "+ (isIdle?"true":"false") +"", 0,20);
		text("isMoving: "+ (isMoving?"true":"false") +"", 0,30);
		text("idleTime: "+ idleTime +"", 0,40);
		text("movingTime: "+ movingTime +"", 0,50);
		popStyle();
	}
	// line(s, 0, s, 33);
	// line(m, 33, m, 66);
	// line(h, 66, h, 100);


	// track for a certain time before starting to record
	getTracker(isMoving);
	lastX = mouse.x;
	lastY = mouse.y;
	// image(buffer, 0, 0);
}
 
public void mousePressed(MouseEvent e) {
	clicked++;
	println("clicked");
}