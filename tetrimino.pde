class Tetrimino {
  int defaultX = 4;
  int defaultY = 0;
  int rotateState = 0;
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
    for (int i = 0; i < piece.length; i++) { //copies piece to temp
      temp[i][0] = piece[i][0];
      temp[i][1] = piece[i][1];
    }
    for (int i = 0; i < piece.length; i++) { //rotates test coordinates of temp
      if (clockwise) {
        temp[i][0] = (-1 * piece[i][1]) + 2;
        temp[i][1] = piece[i][0];
      } else {
        temp[i][0] = piece[i][1];
        temp[i][1] = (-1 * piece[i][0]) + 2;
      }
    }
    int[] translate = testCoord([temp], rotateState, clockwise);
    if (translate[0] == 1) { //copies temp if correct
      for (int i = 0; i < piece.length; i++) {
        piece[i][0] = temp[i][0];
        piece[i][0] = temp[i][1];
      }
      positionX += translate[1];
      positionY += translate[2];
    }
  }

  int[] testCoord(int[][] testCoord, int rotateState, boolean clockwise) {
    //takes the coordinates of the rotated piece, the orientation and if it was clockwise or not
    //returns an array containing [if successful or not (1 if true), shiftX, shiftY]
    int [][] coord = shiftCoord(testCoord, positionX, positionY);
    int shiftX, shiftY = 0;
    if (clockwise) {
      for (int i = 0; i < 5; i++) {
        if (grid.testCoord(shiftCoord(coord, srs[rotateState][i][0], srs[rotateState][i][1])) ) {
          return [1, srs[rotateState][i][0], srs[rotateState][i][1]];
        }
      }
    } else { //TODO: combine for loops 
      rotateState = (rotateState - 1) % 4;
      for (int i = 0; i < 5; i++) {
        if (grid.testCoord(shiftCoord(coord, -1 * srs[rotateState][i][0], -1 * srs[rotateState][i][1])) ) {
          return [1, -1 * srs[rotateState][i][0], -1 * srs[rotateState][i][1]];
        }
      }
    }
    return [0, 0, 0];
  }

  int[][] shiftCoord(int[][] coord, int x, int y) {
    for (int i = 0; i < coord.length; i++) {
      coord[i][0] += x;
      coord[i][1] += y;
    }
    return coord;
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
    this.rotateState = 0;
    gamehandler.setGameOver(!grid.testCoord(this.getCoord())); //checks if game over
    isActive = true;
  }
}
