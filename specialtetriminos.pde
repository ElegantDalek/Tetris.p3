
class Otetris extends Tetrimino {
  Otetris() {
    this.setdefault();
    shade = yellow;
  }
  void setdefault() {
    piece[0][0] = 1;
    piece[0][1] = 0;
    
    piece[1][0] = 2;
    piece[1][1] = 0;
    
    piece[2][0] = 1;
    piece[2][1] = 1;
    
    piece[3][0] = 2;
    piece[3][1] = 1;

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
    piece[0][0] = 0;
    piece[0][1] = 1;
    
    piece[1][0] = 1;
    piece[1][1] = 1;
    
    piece[2][0] = 2;
    piece[2][1] = 1;
    
    piece[3][0] = 3;
    piece[3][1] = 1;
  }
  void rotate(boolean clockwise) {
    if (stateone) {
        piece[0][0] = 1;
        piece[0][1] = 0;
        
        piece[1][0] = 1;
        piece[1][1] = 1;
        
        piece[2][0] = 1;
        piece[2][1] = 2;
        
        piece[3][0] = 1;
        piece[3][1] = 3;
        
        stateone = false;
      }
    else {
      setdefault();
      stateone = true;
    }
    if (!grid.testCoord(this.getCoord())) { //infinite jank, may cause loop?
      this.rotate(clockwise);
    }
  }
}
