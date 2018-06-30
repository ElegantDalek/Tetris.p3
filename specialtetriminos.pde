class FutureTetrimino extends Tetrimino {
  //the gray piece showing where the piece will land if you do a harddrop
  FutureTetrimino(){
    shade = black;
  }
  
  void update() { //just copies activeTetrimino orientation
    for(int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        piece[i][j] = piecehandler.getActive().getPiece()[i][j]; //gets activeTetrimino boolean coordinates of orientation
      }
    }
    this.hardDrop();
  }
  
}

class Otetris extends Tetrimino {
  Otetris() {
    this.setdefault();
    shade = yellow;
  }
  void setdefault() {
    piece[0][0] = false;
    piece[1][0] = true;
    piece[2][0] = true;
    piece[0][1] = false;
    piece[1][1] = true;
    piece[2][1] = true;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
  void rotate(boolean clockwise) {
  }
}

class Itetris extends Tetrimino {
  boolean stateone = true; //only two orientation can be in, true being horizontal false vertical
  Itetris() {
    this.setdefault();
    defaultY = -1;
    shade = cyan;
  }
  
  void setdefault() {
    for (int i = 0; i < 4; i++) { //ONLY FOR IPIECE
      for (int j = 0; j < 4; j++) {
        piece[i][j] = (j == 1);
      }
    }
  }
  void rotate(boolean clockwise) {
    if (stateone) {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          piece[i][j] = (i == 1);
        }
      }
      stateone = false;
    } else {
      setdefault();
      stateone = true;
    }
    if (!grid.testCoord(this.getCoord())) { //infinite jank, may cause loop?
      this.rotate(clockwise);
    }
  }
}
