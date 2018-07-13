class GameHandler {
  int linessent;
  int comboscore;
  boolean gameOver = false;
  GameHandler() {
    linessent = 0;
    comboscore = 0;
  }
  
  boolean isGameOver() {
    return gameOver;
  }
  
  void setGameOver(boolean state) {
    gameOver = state;
  }
  
  void update() {
    gamehandler.showScore();
    if(this.isGameOver()) {
      gamehandler.reset();
    }
  }
  
  void reset() {
    grid.clear();
    bag.reset();
    piecehandler.resetPiece();
    linessent = 0;
    gameOver = false;
  }
  void showScore() {
    fill(black);
    textSize(50);
    text(linessent, 50, 530);
    if(comboscore > 1) {
      textSize(30);
      text("Combo: " + comboscore, 50, 580);
    }
    fill(white);
  }
  
  void addScore(int lines) {
    if (lines == 0) {
      comboscore = 0;
    }
    else if (lines == 1) {
      comboscore += 1;
    }
    else if (lines > 1) {
      linessent += lines;
      comboscore += 1;
    }
  }
}
  
