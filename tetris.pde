final int CELL_WIDTH = 30;
final int CELL_ROWS = 20;
final int CELL_COLUMNS = 10;
final int ORIGINX = 50;
final int ORIGINY = 50;
color cyan = color(44, 218, 240);
color yellow = color(240, 211, 44);
color purple = color(188, 66, 216);
color green = color(132, 255, 3);
color red = color(240, 31, 35);
color blue = color(59, 63, 242);
color orange = color(224, 157, 23);
Ttetris tetrist = new Ttetris();
Grid grid = new Grid();

void setup() {
  size(400, 700);
  frameRate(30);
  background(255);

}

void draw() {
  grid.draw();
  tetrist.draw();
  int time = millis();
  if (time % 1000 < 25){ 
    tetrist.drop();
  }
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      tetrist.move(true);
    }
    else if (keyCode == LEFT) {
      tetrist.move(false);
    }
    else if (keyCode == UP) {
      printArray(tetrist.getCoord(true));
      printArray(tetrist.getCoord(false));
      grid.add(tetrist.getCoord(true), tetrist.getCoord(false), tetrist.getColor());
    }
  }
}

void keyReleased() {

  if (key == ';') {
    tetrist.rotate(false);
  }
  else if (key == 'q') {
    tetrist.rotate(true);
  }
  else if (key == ' ') {
    tetrist.harddrop();
  }
}
