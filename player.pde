class Player {
  int maxIter = 2;
  Player() {
    this.newGame();
  }
  void newGame() {
  }


  int getScore(boolean [][] cells) { // TODO: SCORING 2D ARRAY
    int[] surface = this.getSurfaceCells(cells);
    //return highestPoint(surface);
    return multiplyHeight(surface);
  }

  int multiplyHeight(int[] surface) { // TESTED: AVG: 14, HIGH SCORE: 54
    long sigma = 1;
    for (int i : surface) {
      sigma *= i;
    }
    sigma /= 1000000; // makes sigma fit into a int
    return int(sigma);
  }

  int highestPoint(int[] surface) { 
    // TESTED NO HOLD, LEAF NODE SCORING ONLY, DEFAULT POSITION ON NO OPTIONS: AVG: 73, HIGH SCORE: 488
    // TESTED HOLD, LEAF NODE SCORING ONLY, DEFAULT POSITION ON NO OPTIONS: AVG: 76, HIGH SCORE: 422
    // TESTED HOLD, BRANCH AND LEAF NODE SCORING, DEFAULT POSITION ON NO OPTIONS: AVG: 75, HIGH SCORE: 348
    int highestPoint = 20;
    for (int i : surface) {
      if (i < highestPoint) {
        highestPoint = i;
      }
    }
    return highestPoint;
  }

  void evaluate() { 
    //// TESTING PURPOSES ONLY
    //int xcoord = piecehandler.getXPos();
    //int rotateState = piecehandler.getRotateState();
    //int pieceInt = piecehandler.getPieceInt();
    //boolean[][] cells = grid.getCellCoords();
    //if (rotateState == 1) {
    //  xcoord++;
    //  if (pieceInt == 6) { // I piece
    //    xcoord++;
    //  }
    //} 
    //print("pieceInt: " + pieceInt + "\n");
    //boolean[][] modifiedSurface = modifySurface(xcoord, pieceInt, rotateState, cells );

    //for (int j = 0; j < 20; j++) { // prints out array, only works on fixed size
    //  for (int i = 0; i < 10; i++) {
    //    if (modifiedSurface[i][j]) {
    //      print(" X ");
    //    } else {
    //      print("   ");
    //    }
    //  }
    //  print("\n");
    //}

    //// END TESTING CODE

    int[][] options = new int[40][3]; // 3 parameters: position, rotateState, score
    boolean[][] cells = grid.getCellCoords();
    int optionIndex = 0;
    boolean noOptions = true; // If no options that fit, stays true
    int pieceInt = piecehandler.pieceToInt(piecehandler.getActive());
    for (int rotateState = 0; rotateState < face.getBottomLength(pieceInt); rotateState++) {
      int[] pieceBottom = face.getBottom(pieceInt, rotateState);
      for (int i = 0; i <= CELL_COLUMNS - pieceBottom.length; i++) {
        if (testSurface(i, pieceBottom, this.getSurfaceCells(cells)) ) {
          noOptions = false;
          options[optionIndex][0] = i; // X coord position
          options[optionIndex][1] = rotateState;
          options[optionIndex++][2] = treeSearch(modifySurface(i, pieceInt, rotateState, cells), 1); // score
          print("Option " + str(optionIndex - 1) + ": XPOS: " + i + "rotateState: " + rotateState + " score " + options[optionIndex - 1][2] + "\n");
        }
      }
    }
    this.placePiece(options, noOptions);
  }

  int treeSearch(boolean cells[][], int iter) {
    int pieceInt;
    int[] branchScore = new int[40];
    int scoreIndex = 0;
    int[] surface = this.getSurfaceCells(cells);
    if (iter >= maxIter) { // leaf node
      return this.getScore(cells);
    }
    pieceInt = bag.getQueue(iter - 1);

    // branch code
    for (int rotateState = 0; rotateState < face.getBottomLength(pieceInt); rotateState++) {
      int[] pieceBottom = face.getBottom(pieceInt, rotateState);
      for (int i = 0; i <= CELL_COLUMNS - pieceBottom.length; i++) {
        if (testSurface(i, pieceBottom, surface) ) {
          if (iter != 0) {
            branchScore[scoreIndex++] = treeSearch(modifySurface(i, pieceInt, rotateState, cells), iter + 1);
          } else {
          }
        }
      }
    }
    return this.max(branchScore) + this.getScore(cells);
  }

  void placePiece(int[][] options, boolean noOptions) { // TODO: review if maxIndex needed
    int maxScore = 0;
    int maxPos = 0;
    int maxIndex = 0;
    int rotateState = 0;
    int pieceInt = piecehandler.pieceToInt(piecehandler.getActive());
    for (int i = 0; i < options.length; i++) { // finds highest score 
      if (options[i][2] > maxScore) {
        maxIndex = i;
        maxPos = options[i][0];
        rotateState = options[i][1];
        maxScore = options[i][2];
      }
    }
    if (noOptions && piecehandler.getHeld()) { // holds piece if no options
      piecehandler.hold();
    } else {
      if (rotateState == 1) { // adjusts the xPos to work with grid coordinates
        maxPos -= 1;
        if (pieceInt == 6) {
          maxPos -= 1;
        }
      }
      piecehandler.rotate(rotateState);
      piecehandler.setPosition(maxPos, 0);
      piecehandler.harddrop();
    }
  }

  boolean[][] modifySurface(int xcoord, int pieceInt, int rotateState, boolean[][] cells) {
    boolean[][] cellCopy = new boolean[CELL_COLUMNS][CELL_ROWS];
    for (int i = 0; i < CELL_COLUMNS; i++) { // copies cell to cellcopy for returning and modifying
      for (int j = 0; j < CELL_ROWS; j++) {
        cellCopy[i][j] = cells[i][j];
      }
    }
    int[] top = face.getTop(pieceInt, rotateState);
    int[] bottom = face.getBottom(pieceInt, rotateState);
    int startY = 0;
    int[][] bottomCoord = bottomCoords(xcoord, bottom, startY);
    while (this.testCoord(bottomCoord, cells) ) { // While bottom coordinates are not colliding with exsisting grid cells
      bottomCoord = bottomCoords(xcoord, bottom, ++startY);
    }
    for (int i = 0; i < bottomCoord.length; i++) { // adds piece coords to cells
      for (int j = 1; j <= -1 * top[i]; j++) {
        try { // if future pieces are higher than grid, returns error
          cellCopy[xcoord + i][startY + bottom[i] - j] = true;
        }
        catch (ArrayIndexOutOfBoundsException e) { // TODO: revise in future?
          return cellCopy;
        }
      }
    }
    return cellCopy;
  }

  int[][] bottomCoords(int xcoord, int[] bottom, int startY) { // returns coordinates of bottom cells with absolute reference
    int[][] returnArray = new int[bottom.length][2];
    for (int i = 0; i < bottom.length; i++) {
      returnArray[i][0] = i + xcoord;
      returnArray[i][1] = bottom[i] + startY;
    }
    return returnArray;
  }

  boolean testCoord(int[][] coords, boolean[][] cells) { // returns true if fits
    for (int i = 0; i < coords.length; i++) {
      if (coords[i][1] >= 0) { // if the bottom of the box is lower than the grid
        try {
          if (cells[coords[i][0]][coords[i][1]]) {
            return false;
          }
        } 
        catch (ArrayIndexOutOfBoundsException e) {
          return false;
        }
      } else { // if taller than grid
        return true;
      }
    }
    return true;
  }

  boolean testSurface(int index, int[] pieceBottom, int[] surface) {
    int initHeight = surface[index];
    for (int i = 0; i < pieceBottom.length; i++ ) {
      if (surface[index + i] - initHeight != pieceBottom[i]) {
        return false;
      }
    }
    return true;
  }

  int[] getSurfaceCells(boolean[][] blocks) {
    int[] yValues = new int[CELL_COLUMNS];
    for (int i = 0; i < CELL_COLUMNS; i++) {
      yValues[i] = 20;
      for (int j = 0; j < CELL_ROWS; j++) {
        if (blocks[i][j]) {
          yValues[i] = j;
          break;
        }
      }
    }
    return yValues;
  }

  int max(int[] array) { 
    int max = 0;
    for (int i : array) {
      if (i > max) {
        max = i;
      }
    }
    return max;
  }
}
