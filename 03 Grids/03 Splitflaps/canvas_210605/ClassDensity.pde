class Density implements Comparable<Density> {
  int density = 0;
  char character = 0;
  public Density(int d, char c) {
    density = d;
    character = c;
  }
  
  @Override
    int compareTo(Density other) {
      return this.density - other.density;
    }
    
  void getValues() {
    println(character + " => " + density);
  }
  
  char getCharacter() {
    return character; 
  }    
  
}
