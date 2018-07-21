class GameHandler {
  int linessent;
  int comboscore = -1;
  boolean gameOver = false;
  boolean backToBack = false;
  String announceText = "";
  int initAnnounceTime;
  String[] announceWords = {"Back to Back", "Single!", "Double!", "Triple!"};
  int[] comboRampUp = {0, 0, 1, 1, 1, 3, 3, 4, 4, 4, 4, 4, 5}; //amount of lines sent based on comboscore
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
    backToBack = false;
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
    String lineone = announceText;
    String linetwo = "";
    if (lineone.length() > 11) { //adjusts text to fit beside play field
      int i;
      for (i = 11; lineone.charAt(i) != ' '; i--) {}
      linetwo = lineone.substring(i + 1);
      lineone = lineone.substring(0, i + 1);
    }
    textSize(30);
    fill((millis - initAnnounceTime) / 5); //fades text
    text(lineone, 50, 580);
    text(linetwo, 50, 620);
    fill(white);
  }
  
  void announce(String text) {
    announceText = text;
    initAnnounceTime = millis;
  }

  void addScore(int lines, boolean tSpin) {
    this.tSpinUpdate(lines, tSpin);
    this.comboUpdate(lines);
    if (!tSpin && comboscore < 1) {
      switch(lines) {
      case 0:
        break;
      case 1:
        backToBack = false;
        break;
      case 2:
        backToBack = false;
        this.addLines(lines);
        this.announce("Double!");
        break;
      case 3:
        backToBack = false;
        this.addLines(lines);
        this.announce("Triple!");
        break;
      case 4:
        this.tetris(lines);
        break;
      }
    }
  }
  
  void perfectClear() {
    addLines(10);
  }
  
  void tSpinUpdate(int lines, boolean tSpin) {
    if (tSpin && lines > 0) {
      this.announce("T-spin " + announceWords[lines]);
      if (backToBack) {
        this.announce(announceWords[0] + " Tetris!"); //overrides first statement
        this.addLines(lines * 2 + 1);
      } else {
        this.addLines(lines * 2);
      }
      backToBack = true;
    }
  }
  
  void comboUpdate(int lines) {
    if (lines > 0) {
      comboscore += 1;
      this.addLines(comboRampUp[comboscore]);
      if (comboRampUp[comboscore] > 0) {
        this.announce("Combo: " + comboscore);
      }
    }
    else {
      comboscore = -1;
    }
  }

  void tetris(int lines) {
    if (backToBack) {
      this.announce(announceWords[0] + " Tetris!");
      this.addLines(lines + 1);
    } else {
      this.announce("Tetris!");
      this.addLines(lines);
    }
    backToBack = true;
  }


  void addLines(int lines) {
    linessent += lines;
  }
}
