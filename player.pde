class Player {
  int maxIter = 2;
  Player() {
    this.newGame();
  }

  void newGame() {
  }


  int getScore(int [] surface) { 
    //return highestPoint(surface);
    return multiplyHeight(surface);
  }
  
  int multiplyHeight(int[] surface) { // TESTED: AVG: 14, HIGH SCORE: 54
    long sigma = 1;
    for (int i : surface) {
      sigma *= i;
    }
    sigma /= 1000000;
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
    int[][] options = new int[40][3]; // 3 parameters: position, rotateState, score
    int[] surface = grid.getSurfaceCells();
    int optionIndex = 0;
    boolean noOptions = true;
    int pieceInt = piecehandler.pieceToInt(piecehandler.getActive());
    int[][] pieceBottom = face.getBottom(pieceInt);
    for (int rotateState = 0; rotateState < pieceBottom.length; rotateState++) {
      for (int i = 0; i <= CELL_COLUMNS - pieceBottom[rotateState].length; i++) {
        if (testSurface(i, pieceBottom[rotateState], surface) ) {
          noOptions = false;
          options[optionIndex][0] = i;
          options[optionIndex][1] = rotateState;
          options[optionIndex++][2] = treeSearch(modifySurface(i, pieceInt, rotateState, surface), 1);
        }
      }
    }
    this.placePiece(options, noOptions);
  }

  int treeSearch(int[] surface, int iter) {
    int pieceInt;
    int[] branchScore = new int[40];
    int scoreIndex = 0;
    if (iter >= maxIter) { // leaf node
      return this.getScore(surface);
    }
    pieceInt = bag.getQueue(iter - 1);
    int[][] pieceBottom = face.getBottom(pieceInt); 

    // branch code
    for (int rotateState = 0; rotateState < pieceBottom.length; rotateState++) {
      for (int i = 0; i <= CELL_COLUMNS - pieceBottom[rotateState].length; i++) {
        if (testSurface(i, pieceBottom[rotateState], surface) ) {
          if (iter != 0) {
            branchScore[scoreIndex++] = treeSearch(modifySurface(i, pieceInt, rotateState, surface), iter + 1);
          } else {
          }
        }
      }
    }
    return this.max(branchScore) + this.getScore(surface);
  }

  void placePiece(int[][] options, boolean noOptions) {
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
      if (rotateState == 1) {
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

  int[] modifySurface(int index, int pieceInt, int rotateState, int[] surface) {
    int[] surfaceCopy = new int[surface.length];
    for (int i = 0; i < surface.length; i++) {
      surfaceCopy[i] = surface[i];
    }
    int[] change = face.getTop(pieceInt, rotateState);
    for (int i = 0; i < change.length; i++) {
      surfaceCopy[i + index] += change[i];
    }
    return surfaceCopy;
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
