PImage p;
byte[] b;
String n;
File dir;
String[] list;

void setup(){
	size(1920, 1080);
	// change the size of sketch to resolution of your image(s)

	dir = new File(sketchPath("")+"data");
	list = dir.list();

}

void draw(){
	for (int i = 0; i<list.length; i++){
		if(!list[i].equals("processed") && !list[i].equals(".DS_Store")) {
			println("new file: "+ list[i]);
			n = list[i];
			p = loadImage(n);
			b = loadBytes(n);
			saveBytes("data/processed/"+n, b);

			for (int j = 0; j<int(random(15)); j++){
				b=loadBytes("processed/"+n);
				for(int k=0;k<4;k++) { // 100 changes
			    	int loc=(int)random(128,b.length);//guess at header being 128 bytes at most..
			    	b[loc]=(byte)random(255);
			  	}
			  	saveBytes("data/processed/"+n,b);
			  	p = loadImage("data/processed/"+n);
			}
			image(p, 0, 0);
			save("data/processed/"+n);
			println("saving +++");
		}
	}
  	noLoop();
  	exit();
}

void exit() {
  println("exiting");
  super.exit();
}