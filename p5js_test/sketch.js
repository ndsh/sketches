//OpenSimplexNoise noise = new OpenSimplexNoise();
let t;
let numFrames = 360;
let recording = false;

let n = 8;
let side;
let radius = 150;
let noiseRadius = 2;
let xb, yb;

function setup() {
  createCanvas(500, 500);
  noFill();
  side = width/n;
}

function draw() {
  background(0);
  for(let y=0;y<n;y++) {
    for(let x=0;x<n;x++) {
      stroke(255);
      
      if(dist(x*side, y*side, width/2, height/2) < radius) {
        line(x*side, y*side, (x+1)*side, (y+1)*side);
      } else {
        line((x+1)*side, y*side, x*side, (y+1)*side);
      }
      
    }
  }
}





