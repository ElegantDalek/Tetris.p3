class Tetrimino {
  int defaultX = 4;
  int defaultY = 0;
  int positionX = defaultX;
  int positionY = defaultY;
  color shade = black;
  boolean isActive = false;
  int[][] piece = new int[4][2];


  Tetrimino() {
  }
  void draw() {
    int[][] coord = this.getCoord();
    int[][] shadow = grid.hardDropCoord(coord);
    for (int i = 0; i < coord.length; i++) {
      if (this.isActive()) {
        fill(gray); //shows shadow
        rect(ORIGINX + CELL_WIDTH * shadow[i][0], ORIGINY + CELL_WIDTH * shadow[i][1], CELL_WIDTH, CELL_WIDTH);
      }
      fill(shade);
      rect(ORIGINX + CELL_WIDTH * coord[i][0], ORIGINY + CELL_WIDTH * coord[i][1], CELL_WIDTH, CELL_WIDTH);
      fill(shade);
    }
  }


  void drop() {
    if (this.isActive()) {
      int[][] testDrop = this.getCoord(); //copies coordinates to test with testCoord
      for ( int i = 0; i < testDrop.length; i++) {
        testDrop[i][1] += 1; //Adds predicted drop of 1
      }
      if (grid.testCoord(testDrop)) { 
        positionY += 1; //Increments position
      } else {
        grid.add(this.getCoord(), this.getColor()); //adds location and color data to grid object
        isActive = false;
        piecehandler.nextTetris();
      }
    }
  }

  void hardDrop() {
    grid.add(grid.hardDropCoord(this.getCoord()), this.getColor());
    isActive = false;
    piecehandler.nextTetris();
  }
  
  void setActive(boolean active) {
    this.isActive = active;
  }

  boolean isActive() {
    return isActive;
  }
  void rotate(boolean clockwise) {
    //rotates the piece, takes boolean that if true is clockwise, else counterclockwise
    int[][] temp = new int[4][2];
    for (int i = 0; i < piece.length; i++) {
      temp[i][0] = piece[i][0];
      temp[i][1] = piece[i][1];
    }
    for (int i = 0; i < piece.length; i++) {
      if (clockwise) {
        piece[i][0] = -1 * temp[i][1]+ 2;
        piece[i][1] = temp[i][0];
      } else {
        piece[i][0] = temp[i][1];
        piece[i][1] = (-1 * temp[i][0]) + 2;
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
    } else {
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
    for (int i = 0; i < coord.length; i++ ) {
      coord[i][0] = piece[i][0] + positionX;
      coord[i][1] = piece[i][1] + positionY;
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

  int[][] getPiece() {
    return piece;
  }

  void reset() {
    this.setPosition(defaultX, defaultY);
    this.setdefault();
    gamehandler.setGameOver(!grid.testCoord(this.getCoord())); //checks if game over
    isActive = true;
  }
}
