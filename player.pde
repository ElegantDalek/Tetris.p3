class Player {
  int[] surface = new int[20];
  int[][] options = new int[40][3]; // 3 parameters: position, rotateState, score
  int optionIndex = 0;
  int maxIter = 3;
  Player() {
    this.newGame();
  }

  void newGame() {
    surface = grid.getSurfaceCells();
    for (int i = 0; i < surface.length; i++) {
      print(surface[i] + " ");
    }
    print("\n");
  }

  void evaluate() {
    this.treeSearch(grid.getSurfaceCells(), 0);
  }

  int treeSearch(int[] surface, int iter) {
    int pieceInt;
    int[] branchScore = new int[40];
    int scoreIndex = 0;
    optionIndex = 0;
    if (iter == 0) {
      pieceInt = piecehandler.pieceToInt(piecehandler.getActive());
    } else {
      if (iter >= maxIter) { // leaf node
        return this.getScore(surface);
      }
      pieceInt = bag.getQueue(iter - 1);
    }
    int[][] pieceBottom = face.getBottom(pieceInt);
    for (int rotateState = 0; rotateState < pieceBottom.length; rotateState++) {
      for (int i = 0; i <= CELL_COLUMNS - pieceBottom[rotateState].length; i++) {
        if (testSurface(i, pieceBottom[rotateState], surface) ) {
          if (iter != 0) {
            branchScore[scoreIndex++] = treeSearch(modifySurface(i, pieceInt, rotateState, surface), ++iter);
          } else {
            print("Option #: " + optionIndex + " Position: " + i + " rotateState: " + rotateState + "\n");
            options[optionIndex][0] = i;
            options[optionIndex][1] = rotateState;
            options[optionIndex++][2] = treeSearch(modifySurface(i, pieceInt, rotateState, surface), ++iter);
          }
        }
      }
    }
    if (iter == 0) {
      this.placePiece(options);
    }
    return this.max(branchScore);
  }

  void placePiece(int[][] options) {
    print("placePiece activated");
    int maxScore = 0;
    int maxIndex = 0;
    for (int i = 0; i < options.length; i++) {
      if (options[i][2] > maxScore) {
        maxScore = options[i][2];
        maxIndex = options[i][0];
      }
    }
    print("PLACE PIECE: " + maxIndex + " " + options[maxIndex][1] + " " + maxScore + "\n");
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

  int getScore(int [] surface) { // TODO: One I piece hole scores higher
    int highestPoint = 20;
    for (int i : surface) {
      if (i < highestPoint) {
        highestPoint = i;
      }
    }
    return highestPoint;
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
