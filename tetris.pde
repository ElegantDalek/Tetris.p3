final int CELL_WIDTH = 30;
final int CELL_ROWS = 20;
final int CELL_COLUMNS = 10;
final int ORIGINX = 250;
final int ORIGINY = 50;
final int ORIGINPREVIEWX = 400;
final int ORIGINPREVIEWY = 50;
color cyan = color(44, 218, 240);
color yellow = color(240, 211, 44);
color purple = color(188, 66, 216);
color green = color(132, 255, 3);
color red = color(240, 31, 35);
color blue = color(59, 63, 242);
color orange = color(224, 157, 23);
color black = color(0, 0, 0);
color white = color(255, 255, 255);
color gray = color(175, 175, 175);
Grid grid = new Grid();
GrabBag bag = new GrabBag();
PieceHandler piecehandler = new PieceHandler();
GameHandler gamehandler = new GameHandler();
SRS srs = new SRS();
void setup() {
  size(800, 700);
  frameRate(30);
  background(255);

}

void draw() {
  background(white); //refreshes backgronud, removes lingering pixels
  grid.draw(); //draws the cells, pieces added to grid object
  piecehandler.draw(); //draws currently active piece
  gamehandler.update();
  int time = millis();
  if (time % 1000 < 30){ //timing mechanism seems to not work first time, adjust
    piecehandler.drop();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      piecehandler.move(true);
    }
    else if (keyCode == LEFT) {
      piecehandler.move(false);
    }
    else if (keyCode == UP) {
      piecehandler.rotate(true);
    }
    else if (keyCode == DOWN) {
      piecehandler.drop();
    }
    else if (keyCode == SHIFT) {
      piecehandler.hold();
    }
  }
}

void keyReleased() {

  if (key == ';') {
    piecehandler.rotate(false);
  }
  else if (key == 'q') {
    piecehandler.rotate(true);
  }
  else if (key == ' ') {
    piecehandler.harddrop();
  }
  else if (key == 'p' || key == 'r') {
    gamehandler.reset();
  }
}
