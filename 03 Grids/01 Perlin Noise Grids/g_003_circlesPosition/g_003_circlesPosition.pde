// https://github.com/ndsh/generative_sketches
// Place a Circle in one of 4 positions: top edge, right edge, bottom edge or right edge

ArrayList<Tile> tiles = new ArrayList<Tile>();
int count = 40;

void setup() {
  size(600, 600);
  background(125);
  int size = width/count;
  for (int x = 0; x < count; x++) {
    for (int y = 0; y < count; y++) {
      tiles.add(new Tile(size, x, y));
    }
  }
  for (Tile tile : tiles) {
    tile.display();
  }
} 

void draw() {
} 
