class Tetrimino {
  int defaultX = 3;
  int defaultY = 0;
  int rotateState = 0;
  int positionX = defaultX;
  int positionY = defaultY;
  color shade = black;
  boolean spunIn = false; //used in tspins, if last move before grid.add() was a rotation
  boolean isActive = false;
  int[][] piece = new int[4][2];
  int[][] shadow = new int[4][2];

  Tetrimino() {
  }

  void draw() {
    int[][] coord = this.getCoord();
    for (int i = 0; i < coord.length; i++) {
      if (this.isActive()) {
        cell.draw(shadow[i][0], shadow[i][1], gray);
      }
    }
    for (int i = 0; i < coord.length; i++) {
      cell.draw(coord[i][0], coord[i][1], shade);
    }
  }


  void drop() {
      int[][] testDrop = this.getCoord(); //copies coordinates to test with testCoord
      for ( int i = 0; i < testDrop.length; i++) {
        testDrop[i][1] += 1; //Adds predicted drop of 1
      }
      if (grid.testCoord(testDrop)) { 
        positionY += 1; //Increments position
        spunIn = false;
      } else {
        this.addPiece();
      }
    
  }

  void addPiece() {
    grid.add(this.getCoord(), this.getColor()); //adds location and color data to grid object
    piecehandler.nextTetris();
  }

  void hardDrop() {
    isActive = false;
    grid.add(grid.hardDropCoord(this.getCoord()), this.getColor());
    piecehandler.nextTetris();
  }

  void setActive(boolean active) {
    this.isActive = active;
    if (this.isActive) {
    this.updateShadow();
    }
  }

  void updateShadow() { //repositions piece based on current active piece coords
    shadow = grid.hardDropCoord(this.getCoord());
  }
  boolean isActive() {
    return isActive;
  }

  void rotate(boolean clockwise) {
    //rotates the piece, takes boolean that if true is clockwise, else counterclockwise
    int[][] temp = new int[4][2];
    temp = coordRotate(piece, clockwise);
    int[][] tempCoord = this.shiftCoord(temp, positionX, positionY);//absolute coordinates relative to grid
    for (int i = 0; i < 5; i++) {
      int shiftX = this.getTransX(i, rotateState, clockwise);
      int shiftY = this.getTransY(i, rotateState, clockwise);
      int[][] srsShift = this.shiftCoord(tempCoord, shiftX, shiftY);
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
        spunIn = true;
        this.updateShadow();
        break;
      }
    }
  }

  int getTransX(int i, int rotateState, boolean clockwise) { //returns Xcoordinates using correct srs array
    return srs.getSRSX(i, rotateState, clockwise);
  }

  int getTransY(int i, int rotateState, boolean clockwise) {
    return srs.getSRSY(i, rotateState, clockwise);
  }

  int[][] coordRotate(int[][] coord, boolean clockwise) { //uses coord and rotates it, returning those coordinates
    int[][] returnCoord = new int[4][2];
    for (int i = 0; i < coord.length; i++) {
      if (clockwise) {
        returnCoord[i][0] = -1 * coord[i][1]+ 2;
        returnCoord[i][1] = coord[i][0];
      } else {
        returnCoord[i][0] = coord[i][1];
        returnCoord[i][1] = (-1 * coord[i][0]) + 2;
      }
    }
    return returnCoord;
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

  void move(boolean right) { //TODO: MAKE MORE CONSISE
    if( this.isActive()) {
    int[][] test = this.getCoord(); //copies coordinates to test with testCoord, see drop
    if (right) {
      for ( int i = 0; i < test.length; i++) {
        test[i][0] += 1;
      }
      if (grid.testCoord(test)) {
        positionX += 1;
        this.updateShadow();
      }
    } else {
      for ( int i = 0; i < test.length; i++) {
        test[i][0] -= 1;
      }
      if (grid.testCoord(test)) {
        positionX -= 1;
        this.updateShadow();
      }
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
  
  boolean isTSpin() {
    return false;
  }

  void reset() {
    this.setPosition(defaultX, defaultY);
    this.setdefault();
    this.rotateState = 0;
    this.spunIn = false;
    this.updateShadow();
    gamehandler.setGameOver(!grid.testCoord(this.getCoord())); //checks if game over
    isActive = true;
  }
}
