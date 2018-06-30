class GameHandler {
  int linessent;
  int comboscore;
  GameHandler() {
    linessent = 0;
    comboscore = 0;
  }
  
  void showScore() {
    fill(black);
    textSize(50);
    text(linessent, 50, 530);
    fill(white);
  }
  
  void addScore(int lines) {
    if (lines == 0) {
      comboscore = 0;
    }
    else if (lines == 1) {
      comboscore += 1;
      print(comboscore + "\n");
    }
    else if (lines > 1) {
      linessent += lines;
      comboscore += lines;
      print(comboscore + "\n");
    }
  }
}
  
