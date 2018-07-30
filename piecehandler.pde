class PieceHandler {
  Tetrimino[] piece = new Tetrimino[7];
  Tetrimino[] hold = new Tetrimino[7];
  Tetrimino activeTetrimino;
  Tetrimino heldTetrimino;
  boolean pieceheld; //true if there is a piece held
  boolean switchlock = false; //true if shift already held once on same piece
  PieceHandler() {
    piece[0] = new Ttetris(); //pieces on the actual board
    piece[1] = new Ztetris();
    piece[2] = new Stetris();
    piece[3] = new Ltetris();
    piece[4] = new Jtetris();
    piece[5] = new Otetris();
    piece[6] = new Itetris();

    hold[0] = new Ttetris(); //pieces to be shown in the holding area
    hold[1] = new Ztetris();
    hold[2] = new Stetris();
    hold[3] = new Ltetris();
    hold[4] = new Jtetris();
    hold[5] = new Otetris();
    hold[6] = new Itetris();

    for (int i = 0; i < 7; i++) {
      hold[i].setPosition(-4, 0); // Position of held piece
    }
    activeTetrimino = piece[bag.getPiece()];
    activeTetrimino.setActive(true);
  }

  Tetrimino getActive() {
    return activeTetrimino;
  }

  void hold() {
    Tetrimino temp = activeTetrimino;
    if (!switchlock) {
      if (pieceheld) {
        activeTetrimino = piece[pieceToInt(heldTetrimino)];
        activeTetrimino.reset(); //resets piece to top
        switchlock = true;
      } else {
        this.nextTetris();
        switchlock = true;
      }
      heldTetrimino = hold[pieceToInt(temp)];
    }
    pieceheld = true;
  }
  
  boolean getHeld() {
    return !switchlock;
  }

  int pieceToInt(Tetrimino tetris) {
    for (int i = 0; i <= piece.length; i++) {
      if ( piece[i] == tetris  || hold[i] == tetris) {
        return i;
      }
    }
    return -1; //THIS SHOULD NEVER HAPPEN but Processing is bugging me
  }
  void nextTetris() {
    if (!gamehandler.isGameOver()) {
      boolean tSpin = activeTetrimino.isTSpin(); //needs to be seperate line otherwise grid gets cleared first
      switchlock = false; //for held pieces
      gamehandler.addScore(grid.checkLines(), tSpin);
      if(grid.checkPerfectClear()) {
        gamehandler.perfectClear();
      }
      activeTetrimino.setActive(false);
      activeTetrimino = piece[bag.getPiece()];
      activeTetrimino.setActive(true);
      activeTetrimino.reset();
    }
  }
  void rotate(boolean clockwise) {
    activeTetrimino.rotate(clockwise);
  }

  void draw() {
    if (!gamehandler.isGameOver()) {
      activeTetrimino.draw();
    }
    if (pieceheld) {
      heldTetrimino.draw();
    }
    bag.showPreview(); //draws next 5 pieces
  }

  void drop() {
    activeTetrimino.drop();
  }

  void move(boolean right) {
    activeTetrimino.move(right);
  }

  void newGame() {
    grid.clear();
  }

  void reset() {
    activeTetrimino.reset();
  }
  void harddrop() { // TODO: change to camelCase
    activeTetrimino.hardDrop();
  }
  
  void setPosition(int x, int y) {
    activeTetrimino.setPosition(x, y);
  }
  
  void rotate(int rotateState) {
    if (rotateState == 0) {}
    else if (rotateState == 1) {
      activeTetrimino.rotate(true);
    } else if (rotateState == 2) {
      activeTetrimino.rotate(true);
      activeTetrimino.rotate(true);
    } else if (rotateState == 3) {
      activeTetrimino.rotate(false);
    }
  }

  void resetPiece() {
    activeTetrimino = piece[bag.getPiece()];
    activeTetrimino.reset();
    heldTetrimino = null;
    pieceheld = false;
  }
}
