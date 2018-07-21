class GameHandler {
  int linessent;
  int comboscore;
  boolean gameOver = false;
  boolean backToBack = false;
  String announceText = "";
  int initAnnounceTime;
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
    if (this.isGameOver()) {
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
    drawAnnounceText();
    fill(white);
  }
  
  void drawAnnounceText() {
    textSize(30);
    text(announceText, 50, 580);
    fill(white);
  }
  
  void announce(String text) {
    announceText = text;
    initAnnounceTime = millis;
    print("TIME: " + initAnnounceTime);
  }

  void addScore(int lines, boolean tSpin) {
    this.tSpinUpdate(lines, tSpin);
    //this.comboUpdate(lines);
    if (!tSpin) {
      switch(lines) {
      case 0:
        break;
      case 1:
        backToBack = false;
        break;
      case 2:
        backToBack = false;
        this.addLines(lines);
        break;
      case 3:
        backToBack = false;
        this.addLines(lines);
        break;
      case 4:
        this.tetris(lines);
        break;
      }
    }


  }
  void tSpinUpdate(int lines, boolean tSpin) {
    if (tSpin) {
      this.announce("T-spin!");
      if (backToBack) {
        this.addLines(lines * 2 + 1);
      } else {
        this.addLines(lines * 2);
      }
      backToBack = true;
    }
  }

  void tetris(int lines) {
    this.announce("Tetris!");
    if (backToBack) {
      this.addLines(lines + 1);
    } else {
      this.addLines(lines);
    }
    backToBack = true;
  }


  void addLines(int lines) {
    linessent += lines;
  }
}
