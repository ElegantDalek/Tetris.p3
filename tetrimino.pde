class Tetrimino {
  int positionX = 4;
  int positionY = 0;
  boolean isActive = true;
  boolean[][] piece = new boolean[4][4];

  
  Tetrimino() {
  }
  void draw() {
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        if (piece[i][j]) {
          fill(0);
          rect(ORIGINX + CELL_WIDTH * (positionX + i), ORIGINY + CELL_WIDTH * (positionY + j), CELL_WIDTH, CELL_WIDTH);
          fill(255);
        }
      }
    }
  }
  void drop() {
    if (isActive()) {
      if (grid.clearPath(this.getCoord(true), this.getCoord(false))) {
        positionY += 1;
      }
      else {
        grid.add(this.getCoord(true), this.getCoord(false), this.getColor());
        isActive = false;
        nextTetris();
      }
    }
  }
  void rotate(boolean clockwise) { 
    boolean[][] temp = new boolean[3][3];
  boolean isActive(){
    return isActive;
}
  void rotate(boolean clockwise) {
    //rotates the piece, takes boolean that if true is clockwise, else counterclockwis             for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        temp[i][j] = piece[i][j]; //copies array data
      }
    }
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (clockwise) {
          piece[i][j] = temp[j][-i + 2];
        }
        else {
          piece[i][j] = temp[-j + 2][i];
        }
      }
    }
  }
  
  void move(boolean right) {

    if (right) {
      positionX += 1;
    }
    else {
      positionX -= 1;
    }
  }
  int[] getCoord(boolean wantx) {
    int[] xcoord = new int[4];
    int[] ycoord = new int[4];
    int count = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) { 
        if (piece[i][j]) {
          xcoord[count] = i + positionX;
          ycoord[count] = j + positionY;
          count++;
        }
      }
    }
    if (wantx) { return xcoord; }
    else { return ycoord; }
  }
  
  
  color getColor() {
    return purple;
    //TODO
  }
  
  void nextTetris() {
    tetrist.reset(); 
    //TODO
  }
  
  void reset() {
    positionX = 4;
    positionY = 0;
    isActive = true;
  }
}
