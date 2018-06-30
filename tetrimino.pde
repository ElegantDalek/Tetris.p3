class Tetrimino {
  int defaultX = 4;
  int defaultY = 0;
  int positionX = defaultX;
  int positionY = defaultY;
  color shade = black;
  boolean isActive = true;
  boolean[][] piece = new boolean[4][4];

  
  Tetrimino() {
  }
  void draw() {
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        if (piece[i][j]) {
          fill(shade);
          rect(ORIGINX + CELL_WIDTH * (positionX + i), ORIGINY + CELL_WIDTH * (positionY + j), CELL_WIDTH, CELL_WIDTH); //clunky, make cell object?
          fill(white);
        }
      }
    }
  }
  
  void drop() {
    if (this.isActive()) {
      int[][] testDrop = this.getCoord(); //copies coordinates to test with testCoord
      for ( int i = 0; i < testDrop.length; i++) {
        testDrop[i][1] += 1; //Adds predicted drop of 1
      }
      if (grid.testCoord(testDrop)){ 
        positionY += 1; //Increments position
      }
      else {
        grid.add(this.getCoord(), this.getColor()); //adds location and color data to grid object
        isActive = false;
        piecehandler.nextTetris();
      }
    }
  }
  
  void hardDrop() {
    while( this.isActive() ) {
      this.drop();
    }
  }

  boolean isActive(){
    return isActive;
}
  void rotate(boolean clockwise) {
    //rotates the piece, takes boolean that if true is clockwise, else counterclockwise
    boolean[][] temp = new boolean[3][3];
    for (int i = 0; i < 3; i++) {
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
    if (!grid.testCoord(this.getCoord())) { //infinite jank, may cause loop?
      this.rotate(clockwise);
    }
  }
  
  void setdefault() {
    //sets default orientation for pieces
  }
  
  void move(boolean right) {
    int[][] test = this.getCoord(); //copies coordinates to test with testCoord, see drop
    if (right) {
      for ( int i = 0; i < test.length; i++) {
        test[i][0] += 1; 
      }
      if (grid.testCoord(test)) {
        positionX += 1;
      }
    }
    else {
      for ( int i = 0; i < test.length; i++) {
        test[i][0] -= 1; 
      }
      if (grid.testCoord(test)) {
        positionX -= 1;
      }
    }
  }
  int[][] getCoord() { //gets x and y position of the tetrimino piece, x stored in [i][0], y stored in [i][1]
    int[][] coord = new int[4][2];
    int index = 0;
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          if (piece[i][j]) {
            coord[index][0] = i + positionX;
            coord[index][1] = j + positionY;
            index++;
          }
        }
      }
      return coord;
  }
  
  
  color getColor() {
    return shade;
  }
  
  void setPosition(int x, int y) {
    positionX = x;
    positionY = y;
  }
  
  boolean[][] getPiece() {
    return piece;
  }
  
  void reset() {
    this.setPosition(defaultX, defaultY);
    this.setdefault();
    isActive = true;
  }
}
