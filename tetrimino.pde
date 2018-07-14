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
        cell.draw(shadow[i][0], shadow[i][1], gray);
      }
      fill(shade);
    }
    for (int i = 0; i < coord.length; i++) {
      cell.draw(coord[i][0], coord[i][1], shade);
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
      if (clockwise) {
        temp[i][0] = -1 * piece[i][1]+ 2;
        temp[i][1] = piece[i][0];
      } else {
        temp[i][0] = piece[i][1];
        temp[i][1] = (-1 * piece[i][0]) + 2;
      }
    }
    int[][] tempCoord = this.shiftCoord(temp, positionX, positionY);//absolute coordinates relative to grid
    for (int i = 0; i < 5; i++) {
      int shiftX = srs.getSRSX(i, rotateState, clockwise);
      int shiftY = srs.getSRSY(i, rotateState, clockwise);
      int[][] srsShift = this.shiftCoord(tempCoord, shiftX, shiftY);
      print(grid.testCoord(srsShift) + " " + shiftX + " " + shiftY + "\n");
      if (grid.testCoord(srsShift) ) {
        for (int j = 0; j < piece.length; j++) { //updates orientation
          piece[j][0] = temp[j][0];
          piece[j][1] = temp[j][1];
        }
        positionX += shiftX; //updates translational position
        positionY += shiftY;
        if (clockwise) { //updates rotation state 
          rotateState = (rotateState + 1) % 4;
        } else {
          rotateState = (rotateState + 3) % 4;
        }
        break;
      }
    }
  }

  int[][] shiftCoord(int[][] coord, int x, int y) {
    int[][] copy = new int[4][2];
    for (int i = 0; i < coord.length; i++) {
      copy[i][0] = coord[i][0] + x;
      copy[i][1] = coord[i][1] + y;
    }
    return copy;
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
