class qtFlock{
  ArrayList<qtBoid> boids = new ArrayList<qtBoid>();
  
  qtFlock(int nbBoids){
    for(int i = 0; i < nbBoids; i++){
      boids.add(new qtBoid());
    }
  }
  
  void display(){
    for(qtBoid boid : boids){
      
      ArrayList<Point> query = qtree.query(new Circle(boid.position.x, boid.position.y,
        quadTreeBoidsPerceptionRadiuslider.getValue()),
        null);
      boid.stickyCheck();
      if(globalSticky) {
        temporaries[0] = 0.2; //seperation
        temporaries[1] = 0.5; //alignment
        temporaries[2] = 2; //cohesion
      } else {
        temporaries[0] = separationScaleSlider.getValue();
        temporaries[1] = alignmentScaleSlider.getValue();
        temporaries[2] = cohesionScaleSlider.getValue();
      }
      boid.flock(query);
      boid.wrapAround();
      boid.update();
      boid.display();
    }
  }
}
