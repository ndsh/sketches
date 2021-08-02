class Obstacle {
  PVector position;
  Obstacle(PVector pos) {
    this.position = pos;
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
