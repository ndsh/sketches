class Obstacle {
  PVector position;
  Obstacle(PVector pos) {
    this.position = pos;
  }
}

class Wall {
  PVector start;
  PVector end;
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  boolean finished = false;

  Wall() {
  }

  boolean addPoint(PVector point) {
    if (start == null) {
      setStart(point);
      return false;
    } else if (end == null) {
      setEnd(point);
      return true;
    }
    return false;
  }

  void setStart(PVector point) {
    this.start = point;
  }

  void setEnd(PVector point) {
    this.end = point;
    finished = true;

    obstacles.add(new Obstacle(start));
    obstacles.add(new Obstacle(end));

    float l = PVector.dist(start, end);
    float s = int(l/10);

    for (int j = 1; j<=s; j++) {
      PVector a = start.copy();
      PVector b = end.copy();

      PVector p = a.sub(b).normalize().mult(-j*10).add(start);
      obstacles.add(new Obstacle(p));
    }
  }

  void display() {
    fill(200);
    noStroke();

    if (start != null)
      circle(start.x, start.y, 10);

    if (end != null)
      circle(end.x, end.y, 10);

    if (finished) {
      stroke(wallsColorPicker.getColorValue());
      strokeWeight(wallsSizeSlider.getValue());
      noFill();
      line(start.x, start.y, end.x, end.y);
      /*
      circle(start.x, start.y, 20);
       circle(end.x, end.y, 20);
       
       for (Obstacle p : obstacles)
       circle(p.position.x, p.position.y, 20);*/
    }
  }
}

class SelectionShape{
  float x;
  float y;
}
interface SelectionShapeInterface{
  boolean intersects(Rectangle shape);
  boolean contains(Point point);
}

class Rectangle extends SelectionShape implements SelectionShapeInterface {
  float w;
  float h;

  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    ;
    this.w = w;
    this.h = h;
  }

  float left() {
    return this.x - this.w / 2;
  }

  float right() {
    return this.x + this.w / 2;
  }

  float top() {
    return this.y - this.h / 2;
  }

  float bottom() {
    return this.y + this.h / 2;
  }

  boolean contains(Point point) {
    return (point.x >= this.x - this.w &&
      point.x <= this.x + this.w &&
      point.y >= this.y - this.h &&
      point.y <= this.y + this.h);
  }

  boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
      range.x + range.w < this.x - this.w ||
      range.y - range.h > this.y + this.h ||
      range.y + range.h < this.y - this.h);
  }
}

/*
  Translated from https://github.com/CodingTrain/QuadTree/blob/master/quadtree.js
 */
class Circle extends SelectionShape implements SelectionShapeInterface {
  float r;
  float rSquared;

  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.rSquared = this.r * this.r;
  }

  boolean contains(Point point) {
    // check if the point is in the circle by checking if the euclidean distance of
    // the point and the center of the circle if smaller or equal to the radius of
    // the circle
    float d = pow((point.x - this.x), 2) + pow((point.y - this.y), 2);
    return d <= this.rSquared;
  }

  boolean intersects(Rectangle range) {
    float xDist = Math.abs(range.x - this.x);
    float yDist = Math.abs(range.y - this.y);

    // radius of the circle
    float r = this.r;

    float w = range.w;
    float h = range.h;

    float edges = pow((xDist - w), 2) + pow((yDist - h), 2);

    // no intersection
    if (xDist > (r + w) || yDist > (r + h))
      return false;

    // intersection within the circle
    if (xDist <= w || yDist <= h)
      return true;

    // intersection on the edge of the circle
    return edges <= this.rSquared;
  }
}
