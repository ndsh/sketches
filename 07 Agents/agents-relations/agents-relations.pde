ArrayList<Orbiter> orbiters = new ArrayList<Orbiter>();

PGraphics pg;

float wall = 25;

void setup() {
  size(600, 600);
  pg = createGraphics(400, 400);
  
  
  orbiters.add(new Orbiter(pg));
  orbiters.add(new Orbiter(pg, orbiters.get(0), true));
  orbiters.add(new Orbiter(pg, orbiters.get(0), true));
  orbiters.add(new Orbiter(pg, orbiters.get(1), false));
  orbiters.add(new Orbiter(pg, orbiters.get(1), false));
  orbiters.add(new Orbiter(pg, orbiters.get(2), false));
  orbiters.add(new Orbiter(pg, orbiters.get(2), false));
}

void draw() {
  background(0);
  for (Orbiter orbiter : orbiters) {
  orbiter.run();
  }
  image(pg, 0, 0);
}